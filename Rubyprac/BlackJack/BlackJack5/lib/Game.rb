class Game
  require 'Pry'
  require './Deck.rb'
  require './Player.rb'
  attr_reader

  def initialize
    @deck = Deck.new
    @players = []
    @player_names = []
    @dealer_hand = nil
  end

  def start
    system "clear"
    puts "Welcome to Blackjack!"
    puts

    self.make_player_list

    loop do
      system "clear"
      if @deck.cards_remaining.length < 20
        @deck = Deck.new
        puts "The deck has been reshuffled."
        puts
      end

      @players.each do |player|
        puts "#{player.name} has $#{player.money}."
        player.get_wager
        puts "#{player.name} bet $#{player.wager}."
        puts
      end

      @dealer_hand = Hand.new(@deck.draw_card, @deck.draw_card)

      self.player_turns
      self.dealer_turn
      self.show_final_scores
      self.round_summary

      if self.replay
        system "clear"
        self.boot_players
        self.leaving_players if @players.length > 0
        if @players.length < 4
          system "clear"
          self.new_players
        end
        system "clear"
        puts "NEW ROUND"
        self.clear_screen
      else
        break
      end

      if @players.empty?
        puts "Goodbye"
        gets
        exit
      end
    end
  end

  def hand_number(player, hand_index)
    if player.hand_list.length == 1
      return ''
    elsif hand_index == 0
      return '1st '
    elsif hand_index == 1
      return '2nd '
    elsif hand_index == 2
      return '3rd '
    elsif hand_index == 3       #ask EEs about not using an else
      return '4th '
    end
  end

  def get_player_num
    player_num = nil
    loop do
      player_num = gets.chomp
      if player_num.to_i.to_s == player_num && player_num.to_i < 5
        puts
        return player_num.to_i
      else
        puts "Please enter a number between 1 and 4"
      end
    end
  end

  def player_turns
    @players.each do |player|
      self.clear_screen
      player.new_hand @deck.draw_card, @deck.draw_card
      #player.new_hand Card.new('7','♦'), Card.new('7','♠') #testing splits or player_blackjack

      player.hand_list.each_with_index do |hand, hand_index|
        loop do
          self.clear_screen if player.hand_list[1] || hand.card_list.length != 2
          puts "#{player.name}'s #{self.hand_number(player, hand_index)}hand is:"
          hand.show_hand
          puts
          if (hand.hand_total) == 21
            puts "BLACKJACK!"
            break
          elsif (hand.hand_total) > 21
            puts "Oops. #{player.name} went over 21."
            break
          end
          puts "The dealer has:"
          puts "#{@dealer_hand.show_card_at(0)} Total = #{@dealer_hand.card_list[0].value}"
          puts
          puts "#{player.name}, what would you like to do?"
          puts "1. Hit Me"
          puts "2. Stay"
          puts "3. Split" if hand.check_split && player.hand_list.length < 4     #clean up: combine .check_split & player.hand_list.length < 4

          player_action = player.get_player_action(hand_index)
          puts
          if player_action == "1"
            puts "#{player.name} decides to hit."
            hand.hit_me(@deck.draw_card)
          elsif player_action == "3" && hand.check_split && player.hand_list.length <= 4
            puts "#{player.name} decides to split the hand and add $#{player.wager} to the wager"
            player.split_hand(hand_index, @deck.draw_card, @deck.draw_card)
          else
            puts "#{player.name} decides to stay."
            break
          end

        end # end get player action loop
      end # end hand_list.each loop
    end #end players.each loop
    self.clear_screen
  end

  def dealer_turn
    puts "The dealer's second card is #{@dealer_hand.show_card_at(1)}."
    puts

    loop do
      puts "The dealer has:"
      @dealer_hand.show_hand
      puts
      if @dealer_hand.hand_total == 21
        puts "BLACKJACK!"
        break
      elsif @dealer_hand.hand_total > 21
        puts "The dealer went over 21."
        break
      elsif @dealer_hand.hand_total < 17
        puts "The dealer hits."
        puts
        @dealer_hand.hit_me(@deck.draw_card)
        sleep(1)
      else
        puts "The dealer stays."
        break
      end
    end
  end

  def show_final_scores
    @players.each do |player|
      self.clear_screen
      puts "Final score:"
      puts "Dealer's hand:"
      @dealer_hand.show_hand
      puts "BLACKJACK!" if @dealer_hand.hand_total == 21
      puts

      puts "#{player.name}'s hand#{'s' if player.hand_list.length > 1}:"

      player.hand_list.each_with_index do |hand, hand_index|
        hand.show_hand
        puts "BLACKJACK!" if hand.hand_total == 21
        if hand.hand_total > 21 && @dealer_hand.hand_total > 21
          puts "Both hands were over 21. Wager will be returned."
        elsif hand.hand_total > 21
          puts "#{player.name}'s hand was over 21."
          player.lose_wager
        elsif @dealer_hand.hand_total > 21
          puts "The dealer's hand was over 21."
          player.win_wager
        elsif hand.hand_total == @dealer_hand.hand_total
          puts "It's a tie! Wager will be returned."
        elsif hand.hand_total > @dealer_hand.hand_total
          puts "#{player.name}'s hand beats the dealer's hand."
          player.win_wager
        else
          puts "#{player.name}'s hand loses to the dealer's hand."
          player.lose_wager
        end
        puts
      end #end hand_list.each loop
    end #ends players.each loop
    self.clear_screen
  end

  def round_summary
    puts 'Round Summary:'
    puts
    @players.each do |player|
      player.report_result_summary
      puts "#{player.name} currently has $#{player.money}."
      puts
    end
  end

  def boot_players
    @players.each do |player|
      if player.money == 0
        puts "#{player.name} has run out of money and has to leave the table."
      end
      @players = @players.select{|player| player.money != 0}
    end
    self.clear_screen
  end

  def leaving_players
    puts "Do any players wish to leave the table?"
    if self.yes_or_no == "yes"
      puts "Please list any players who wish to leave the table."
      puts 'Enter "stop" to stop.'
      loop do
        name = gets.chomp.capitalize
        if name == "Stop"
          break
        elsif @player_names.include?(name)
          @players.each do |player|
            @players.delete(player) if name == player.name
            @player_names.delete(name)
          end
          puts "#{name.capitalize} has left the table."
          if @players.empty?
            gets
            break
          end
          puts "Anyone else?"
          puts 'Enter "stop" to stop.'
        else
          puts "That is not a player's name."
        end
      end
    end
  end

  def new_players
    puts "Does anyone wish to join the table?"
    if self.yes_or_no == "yes"
      puts "Who wishes to join the table?"
      puts 'Enter "stop" to stop.'
      loop do
        name = gets.chomp.capitalize
        puts
        if name == "Stop"
          break
        elsif name == ""
          puts "Please enter a name."
        elsif @player_names.include?(name)
          puts "That name is aready taken. Please try another name."
        else
          @players << Player.new(name.capitalize, 100)
          @player_names << name
          puts "#{@players.last.name} has joined the table."
          break if @players.length == 4
          puts
          puts "Anyone else?"
          puts 'Enter "stop" to stop.'
        end
      end
    end
  end

  def yes_or_no
    loop do
      response = gets.chomp.downcase
      if response == "y" || response == "yes"
        return "yes"
      elsif response == "n" || response == "no"
        return "no"
      else
        puts "Please enter yes or no."
      end
    end
  end

  def make_player_list
    puts "How many people will be playing? (max 4)"
    self.get_player_num.times do |player|
      puts "Player #{player + 1}, what is your name?"
      loop do
        names = self.get_player_names
        name = gets.chomp.capitalize
        if name == ""
          puts "Please enter a name."
        elsif names.include?(name)
          puts "That name is aready taken. Please try another name."
        else
          @players << Player.new(name, 100)
          @player_names << name
          puts
          break
        end
      end
    end
  end

  def get_player_names
    names = []
    @players.each do |player|
      names << player.name
    end
    return names
  end

  def clear_screen
    gets.chomp
    system "clear"
  end

  def replay
    loop do
      puts "Do you want to play another round? (yes or no)"
      play_again_answer = gets.chomp.downcase
      puts
      if play_again_answer == "y" || play_again_answer == "yes"
        return true
      elsif play_again_answer == "n" || play_again_answer == "no"
        puts "Ending the game..."
        return false
      else
        puts "Please only enter yes or no."
      end
    end
  end

end

game = Game.new
game.start
