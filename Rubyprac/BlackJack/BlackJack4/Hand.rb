class Hand
  attr_reader :card_list

  def initialize card1, card2
    @card_list = [card1, card2]
  end

  def hand_total
    loop do
      total = @card_list.inject(0){|sum, card| sum + card.value}
      if total > 21 && self.contains_a11
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
    @card_list.each do |card|
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
