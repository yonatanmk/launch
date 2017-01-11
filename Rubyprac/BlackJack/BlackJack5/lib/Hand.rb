# require_relative 'Card.rb'
# require 'Pry'

class Hand
  attr_reader :card_list

  def initialize card1, card2
    @card_list = [card1, card2]
  end

  def hand_total
    cards = @card_list.sort {|card, _| card.value == 11 ? 1 : -1}
    total = cards.reduce(0) do |sum, card|
      if card.value == 11 && sum > 10
        @card_list[cards.index(card)].value_to_1
        sum + 1
      else
        sum + card.value
      end
    end
    return total
  end

  def hit_me card
    @card_list << card
  end

  def show_hand
    require 'colorize'
    @card_list.each do |card|
      card_desc = "#{card.face}#{card.symbol}"
      if ['♥', '♦'].include?(card.symbol)
        card_desc = card_desc.colorize(:red)
      else
        card_desc = card_desc.colorize(:black)
      end
      card_desc = card_desc.colorize(:background => :white)
      print card_desc + ' '
    end
    puts "Total = #{self.hand_total}"
  end

  def show_card_at(index)
    require 'colorize'
    card = "#{@card_list[index].face}#{@card_list[index].symbol}"
    if ['♥', '♦'].include?(@card_list[index].symbol)
      card = card.colorize(:red)
    else
      card = card.colorize(:black)
    end
    card = card.colorize(:background => :white)
    return card
  end

  def check_split
    if @card_list.length > 2
      return false
    elsif @card_list[0].value == @card_list[1].value
      return true
    else
      return false
    end
  end

end

# ['♠', '♥', '♦', '♣']
# hand = Hand.new(Card.new('A', '♣'), Card.new('A', '♦'))
# puts hand.hand_total
