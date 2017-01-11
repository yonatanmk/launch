require './Hand.rb'

class Dealer
  attr_reader :hand

  def initialize card1, card2
    @hand = Hand.new(card1, card2)
  end

end
