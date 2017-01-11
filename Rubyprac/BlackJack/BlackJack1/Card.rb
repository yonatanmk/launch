class Card
  attr_accessor :symbol, :face, :value

  def initialize(face, symbol)
    @face = face
    @symbol = symbol
    if ['10', 'J', 'Q', 'K'].include?(face)
      @value = 10
    elsif face == 'A'
      @value = 11
    else
      @value = face.to_i
    end
  end

  def value_to_1
    @value = 1
  end
end
