require 'Pry'

require './Deck.rb'
require './Player.rb'
require './replay.rb'

deck = Deck.new

system "clear"

puts "Welcome to Blackjack!"
puts
puts "What is your name?"
player = Player.new gets.chomp.capitalize, 100
puts

binding.pry

loop do
  system "clear"
  if deck.cards_remaining.length < 20
    deck = Deck.new
    puts "The deck has been reshuffled."
    puts
  end
  #player.new_hand deck.draw_card, deck.draw_card
  player.new_hand Card.new('8','♦'), Card.new('A','♦') #testing player_blackjack
  dealer = Dealer.new deck.draw_card

  puts "You have $#{player.money}."
  player.get_wager
  player.increase_wager_count
  puts "You bet $#{player.wager}."
  puts

  loop do
    puts "#{player.name}'s hand is:"
    player.show_hand
    puts
    if (player.hand_total) == 21
      puts "BLACKJACK!"
      break
    elsif (player.hand_total) > 21
      puts "Oops. #{player.name} went over 21."
      break
    end
    puts
    puts "The dealer has:"
    dealer.show_hand
    puts
    puts "What would you like to do?"
    puts "1. Hit Me"
    puts "2. Stay"

    player_action = player.get_player_action
    puts

    if player_action == "1"
      puts "#{player.name} decides to hit."
      player.hit_me deck.draw_card
    # elsif player_action == "3"
    #   puts "You decide to split your hand and add $#{player.wager} to your wager"
    #   player.split_hand hand
    #   player.wager_count += 1
    #   puts player.wager_count
    else
      puts "#{player.name} decides to stay."
      break
    end

  end # end get player action loop

  puts
  dealer.hit_me deck.draw_card
  unless player.hand.length == 2 && player.hand_total == 21
    puts "The dealer's second card is #{dealer.show_card2}."
  end

  while true
    puts "The dealer has:"
    dealer.show_hand
    puts
    if dealer.hand_total == 21
      puts "BLACKJACK!"
      break
    elsif dealer.hand_total > 21
      puts "The dealer went over 21."
      break
    elsif dealer.hand_total < 17
      puts "The dealer hits."
      puts
      dealer.hit_me deck.draw_card
    else
      puts "The dealer stays."
      break
    end
  end

  puts
  puts "Final score:"
  puts "#{player.name}'s hand:"
  player.show_hand
  puts "Dealer's hand:"
  dealer.show_hand
  puts
  if player.hand_total > 21 && dealer.hand_total > 21
    puts "Both hands were over 21. All wagers will be returned."
  elsif player.hand_total > 21
    puts "#{player.name}'s hand was over 21."
    puts "#{player.name} loses!"
    player.lose_wager
  elsif dealer.hand_total > 21
    puts "The dealer's hand was over 21."
    puts "#{player.name} wins!"
    player.win_wager
  elsif player.hand_total == dealer.hand_total
    puts "It's a tie! All wagers will be returned."
  elsif player.hand_total > dealer.hand_total
    puts "#{player.name}'s hand beats the dealer's hand."
    puts "#{player.name} wins!"
    player.win_wager
  else
    puts "#{player.name}'s hand loses to the dealer's hand."
    puts "#{player.name} loses!"
    player.lose_wager
  end

  puts "#{player.name} currently has $#{player.money}."

  if replay
    player.discard_hand
  else
    break
  end
end
