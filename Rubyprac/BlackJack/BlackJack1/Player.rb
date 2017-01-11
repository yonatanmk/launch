require 'colorize'
require './Dealer.rb'

class Player < Dealer #inherit hand_total, hit_me, show_hand
  attr_reader :name, :money, :wager, :wager_count#, :hand_list

  def initialize name, money
    @name = name
    @wager = nil
    @wager_count = 0
    # @hand_list = [[], [], [], []]
    @money = money
    @hand = []
  end

  def new_hand card1, card2
    @hand = [card1, card2]
  end

  def discard_hand
    @hand = []
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

  def increase_wager_count
    @wager_count += 1
  end

  def lose_wager
    @money -= @wager
  end

  def win_wager
    @money += @wager
  end

  def get_player_action #hand
    while true
      player_action = gets.chomp.downcase
      if player_action == "1" or player_action == "hit me"
        return "1"
        break
      elsif player_action == "2" or player_action == "stay"
        return "2"
        break
      # elsif player_action == "3" or player_action == "split"
      #   if self.check_split hand
      #     if (self.wager * (wager_count + 1)) > self.money
      #       puts "You cannot afford to split your hand."
      #       puts "Please select option 1 or 2."
      #     else
      #       return "3"
      #       break
      #     end
      #   else
      #     puts "Please select option 1 or 2."
      #   end
      else
        puts "Please select option 1 or 2." #if !self.check_split hand
        #puts "Please select option 1, 2, or 3." #if self.check_split hand
      end
    end
  end

end
