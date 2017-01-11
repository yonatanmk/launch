class hand
  attr_reader

  def initialize
    @card_list = []
  end

  def hand_total
    loop do
      total = @card_list.inject(0){|sum, card| sum + card.value}
      if total > 21 && self.hand_contains_a11
        @card_list.each do |card|
          if card.face == 'A' && card.value == 11
            card.value_to_1
            break
          end
        end
      else
        return total
      end
    end
  end

  def contains_a11
    @hand.each do |card|
      return true if card.face == 'A' && card.value == 11
    end
    return false
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

  def show_card2
    require 'colorize'
    card = "#{@card_list[1].face}#{@card_list[1].symbol}"
    if ['♥', '♦'].include?(@card_list[1].symbol)
      card = card.colorize(:red)
    else
      card = card.colorize(:black)
    end
    card = card.colorize(:background => :white)
    return card
  end

end
