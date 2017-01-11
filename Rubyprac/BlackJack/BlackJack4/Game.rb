

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

def leaving_players (players)
  name_list = []
  players.each do |player|
    name_list << player.name.downcase
  end
  puts "Do any players wish to leave the table?"
  if yes_or_no == "yes"
    puts "Please list any players who wish to leave the table."
    puts 'Enter "stop" to stop.'
    binding.pry
    loop do
      name = gets.chomp.downcase
      if name == "stop"
        break
      elsif name_list.include?(name)
        players.each do |player|
          players.delete(player) if name == player.name
        end
      else
        puts "That is not a player's name."
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
    end
  end
end

def make_player_list
  puts "How many people will be playing? (max 4)"
  players = []
  get_player_num.times do |player|
    puts "Player #{player + 1}, what is your name?"
    loop do
      name = gets.chomp.capitalize
      if players.include?(name)
        puts "That name is aready taken. Please try another name."
      else
        players << Player.new(name, 100)
        puts
        break
      end
    end
  end
  return players
end

def clear_screen
  gets.chomp
  system "clear"
end

#___________________________
system "clear"
deck = Deck.new

puts "Welcome to Blackjack!"
puts

players = make_player_list

# new dealer hand method
loop do
  system "clear"
  if deck.cards_remaining.length < 20
    deck = Deck.new
    puts "The deck has been reshuffled."
    puts
  end

  players.each do |player|
    puts "#{player.name} has $#{player.money}."
    player.get_wager
    puts "#{player.name} bet $#{player.wager}."
    puts
  end

  dealer_hand = Hand.new(deck.draw_card, deck.draw_card)

  players.each do |player|
    clear_screen
    player.new_hand deck.draw_card, deck.draw_card
    #player.new_hand Card.new('7','♦'), Card.new('7','♠') #testing player_blackjack

    player.hand_list.each_with_index do |hand, hand_index|
      loop do
        clear_screen if player.hand_list[1] || hand.card_list.length != 2
        puts "#{player.name}'s #{hand_number(player, hand_index)}hand is:"
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
        puts "#{dealer_hand.show_card_at(0)} Total = #{dealer_hand.card_list[0].value}"
        puts
        puts "#{player.name}, what would you like to do?"
        puts "1. Hit Me"
        puts "2. Stay"
        puts "3. Split" if hand.check_split && player.hand_list.length < 4     #clean up: combine .check_split & player.hand_list.length < 4

        player_action = player.get_player_action(hand_index)
        puts
        if player_action == "1"
          puts "#{player.name} decides to hit."
          hand.hit_me(deck.draw_card)
        elsif player_action == "3" && hand.check_split && player.hand_list.length <= 4
          puts "#{player.name} decides to split the hand and add $#{player.wager} to the wager"
          player.split_hand(hand_index, deck.draw_card, deck.draw_card)
        else
          puts "#{player.name} decides to stay."
          break
        end

      end # end get player action loop
    end # end hand_list.each loop
  end #end players.each loop

  clear_screen

  puts "The dealer's second card is #{dealer_hand.show_card_at(1)}."
  puts

  loop do
    puts "The dealer has:"
    dealer_hand.show_hand
    puts
    if dealer_hand.hand_total == 21
      puts "BLACKJACK!"
      break
    elsif dealer_hand.hand_total > 21
      puts "The dealer went over 21."
      break
    elsif dealer_hand.hand_total < 17
      puts "The dealer hits."
      puts
      dealer_hand.hit_me(deck.draw_card)
    else
      puts "The dealer stays."
      break
    end
  end

  players.each do |player|
    clear_screen
    puts "Final score:"
    puts "Dealer's hand:"
    dealer_hand.show_hand
    puts "BLACKJACK!" if dealer_hand.hand_total == 21
    puts

    puts "#{player.name}'s hand#{'s' if player.hand_list.length > 1}:"

    player.hand_list.each_with_index do |hand, hand_index|
      hand.show_hand
      puts "BLACKJACK!" if hand.hand_total == 21
      if hand.hand_total > 21 && dealer_hand.hand_total > 21
        puts "Both hands were over 21. Wager will be returned."
      elsif hand.hand_total > 21
        puts "#{player.name}'s hand was over 21."
        player.lose_wager
      elsif dealer_hand.hand_total > 21
        puts "The dealer's hand was over 21."
        player.win_wager
      elsif hand.hand_total == dealer_hand.hand_total
        puts "It's a tie! Wager will be returned."
      elsif hand.hand_total > dealer_hand.hand_total
        puts "#{player.name}'s hand beats the dealer's hand."
        player.win_wager
      else
        puts "#{player.name}'s hand loses to the dealer's hand."
        player.lose_wager
      end
      puts
    end #end hand_list.each loop
  end #ends players.each loop

  clear_screen

  puts 'Round Summary:'
  puts
  players.each do |player|
    player.report_result_summary
    puts "#{player.name} currently has $#{player.money}."
    puts
  end

  if replay
    leaving_players(players)
    new_players
    gets.chomp
  else
    break
  end

  break if players.empty?
end
