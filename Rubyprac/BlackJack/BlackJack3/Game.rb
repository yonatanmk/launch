require 'Pry'

require './Deck.rb'
require './Player.rb'
require './Dealer.rb'
require './replay.rb'

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

#___________________________

deck = Deck.new

system "clear"

puts "Welcome to Blackjack!"
puts
puts "What is your name?"
player = Player.new gets.chomp.capitalize, 100
puts

loop do
  system "clear"
  if deck.cards_remaining.length < 20
    deck = Deck.new
    puts "The deck has been reshuffled."
    puts
  end
  player.new_hand deck.draw_card, deck.draw_card
  #player.new_hand Card.new('7','♦'), Card.new('7','♠') #testing player_blackjack
  dealer = Dealer.new(deck.draw_card, deck.draw_card)

  puts "You have $#{player.money}."
  player.get_wager
  puts "You bet $#{player.wager}."
  puts

  player.hand_list.each_with_index do |hand, hand_index|
    loop do
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
      puts "#{dealer.hand.show_card_at(0)} Total = #{dealer.hand.card_list[0].value}"
      puts
      puts "What would you like to do?"
      puts "1. Hit Me"
      puts "2. Stay"
      puts "3. Split" if hand.check_split && player.hand_list.length < 4     #clean up: combine .check_split & player.hand_list.length < 4

      player_action = player.get_player_action(hand_index)
      puts
      if player_action == "1"
        puts "#{player.name} decides to hit."
        hand.hit_me(deck.draw_card)
      elsif player_action == "3" && hand.check_split && player.hand_list.length <= 4
        puts "You decide to split your hand and add $#{player.wager} to your wager"
        player.split_hand(hand_index, deck.draw_card, deck.draw_card)                                            #clean up: remove wage_count for final
      else
        puts "#{player.name} decides to stay."
        break
      end

    end # end get player action loop
  end # end hand_list.each loop

  puts
  puts "The dealer's second card is #{dealer.hand.show_card_at(1)}."

  while true
    puts "The dealer has:"
    dealer.hand.show_hand
    puts
    if dealer.hand.hand_total == 21
      puts "BLACKJACK!"
      break
    elsif dealer.hand.hand_total > 21
      puts "The dealer went over 21."
      break
    elsif dealer.hand.hand_total < 17
      puts "The dealer hits."
      puts
      dealer.hand.hit_me(deck.draw_card)
    else
      puts "The dealer stays."
      break
    end
  end

  puts
  puts "Final score:"
  puts "Dealer's hand:"
  dealer.hand.show_hand
  puts
  puts "#{player.name}'s hand#{'s' if player.hand_list.length > 1}:"

  player.hand_list.each_with_index do |hand, hand_index|
    hand.show_hand
    if hand.hand_total > 21 && dealer.hand.hand_total > 21
      puts "Both hands were over 21. Wager will be returned."
    elsif hand.hand_total > 21
      puts "#{player.name}'s hand was over 21."
      player.lose_wager
    elsif dealer.hand.hand_total > 21
      puts "The dealer's hand was over 21."
      player.win_wager
    elsif hand.hand_total == dealer.hand.hand_total
      puts "It's a tie! Wagers will be returned."
    elsif hand.hand_total > dealer.hand.hand_total
      puts "#{player.name}'s hand beats the dealer's hand."
      player.win_wager
    else
      puts "#{player.name}'s hand loses to the dealer's hand."
      player.lose_wager
    end
    puts
  end #end hand_list.each loop

  player.report_result_summary
  puts "#{player.name} currently has $#{player.money}."

  unless replay
    break
  end
end
