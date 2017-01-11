require './Player.rb'
require 'Pry'

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
  players = []
  2.times do |player|
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

def leaving_players (players) #remove players local var and add auto stop if players.empty?
  name_list = []
  players.each do |player|
    name_list << player.name.downcase
  end
  puts "Do any players wish to leave the table?"
  if yes_or_no == "yes"
    puts "Please list any players who wish to leave the table."
    puts 'Enter "stop" to stop.'
    loop do
      name = gets.chomp.downcase
      if name == "stop"
        break
      elsif name_list.include?(name)
        players.each do |player|
          players.delete(player) if name == player.name.downcase
        end
        puts "#{name.capitalize} has left the table."
        binding.pry
        puts "Anyone else?"
        puts 'Enter "stop" to stop.'
      else
        puts "That is not a player's name."
      end
    end
  end
end

def new_players (players)
  puts "Does anyone wish to join the table?"
  if yes_or_no == "yes"
    puts "Who wishes to join the table?"
    puts 'Enter "stop" to stop.'
    loop do
      name = gets.chomp.downcase
      puts
      if name == "stop"
        break
      else
        players << Player.new(name, 100)
        puts "#{players.last.name} has joined the table."
        break if players.length == 4
        puts
        puts "Anyone else?"
        puts 'Enter "stop" to stop.'
      end
    end
  end
  return players
end

system "clear"

players = make_player_list

leaving_players(players)
#new_players(players) unless players.length == 4
