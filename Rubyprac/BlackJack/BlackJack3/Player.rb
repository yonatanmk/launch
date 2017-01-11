require 'colorize'
require './Hand.rb'

class Player
  attr_reader :name, :money, :wager, :hand_list

  def initialize name, money
    @name = name
    @wager = nil
    @hand_list = nil
    @money = money
    @winnings = 0
  end

  def new_hand card1, card2
    @hand_list = [Hand.new(card1, card2)]
  end

  def get_wager
    while true
      puts "How much would you like to wager?"
      @wager = gets.chomp
      if @wager.to_i.to_s == @wager
        if @wager.to_i < 5
          puts "The minimum wager is $5."
        elsif @wager.to_i > @money
          puts "You cannot afford that wager."
        else
          @wager = @wager.to_i
          break
        end
      else
        puts "Please enter an integer with no symbols, spaces, or letters."
      end
    end
  end

  def lose_wager
    puts "#{@name} loses!"
    @winnings -= @wager
  end

  def win_wager
    puts "#{@name} wins!"
    @winnings += @wager
  end

  def report_result_summary
    unless @winnings == 0
      puts "#{@name} has #{@winnings > 0 ? 'won' : 'lost'} $#{@winnings.abs}."
    end
    @money += @winnings
    @winnings = 0
  end

  def get_player_action(hand_index)
    while true
      player_action = gets.chomp.downcase
      if player_action == "1" or player_action == "hit me"
        return "1"
        break
      elsif player_action == "2" or player_action == "stay"
        return "2"
        break
      elsif player_action == "3" or player_action == "split"
        if @hand_list[hand_index].check_split
          if @hand_list.length < 4
            if (@wager * (@hand_list.length + 1)) > @money
              puts "You cannot afford to split your hand."
              puts "You currently have $#{@money} and you're currently wagering $#{@wager * @hand_list.length}."
              puts "Please select option 1 or 2."
            else
              return "3"
              break
            end
          else
            puts "You already have the maximum number of hands allowed."
          end
        else
          puts "Please select option 1 or 2."
        end
      else
        if @hand_list[hand_index].check_split && @hand_list.length < 4
          puts "Please select option 1, 2 or 3."
        else
          puts "Please select option 1 or 2."
        end
      end
    end
  end

  def split_hand(hand_index, card1, card2)
    @hand_list << Hand.new(@hand_list[hand_index].card_list.pop, card1)
    @hand_list[hand_index].card_list << card2
  end

end
