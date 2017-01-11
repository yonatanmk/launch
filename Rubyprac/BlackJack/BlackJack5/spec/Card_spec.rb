require_relative '../lib/Card.rb'
# ♠ ♥ ♦ ♣

describe 'Card:' do

  context '2♥ card has appropriate values:' do
    subject(:card) {Card.new('2', '♥')}
    it '2♥ card has face value of "2"' do
      expect(card.face).to eq('2')
    end
    it '2♥ card has symbol value of "♥"' do
      expect(card.symbol).to eq('♥')
    end
    it '2♥ card has value of 2' do
      expect(card.value).to eq(2)
    end
    it '2♥ card retains value of 2 after calling .value_to_1' do
      card.value_to_1
      expect(card.value).to eq(2)
    end
  end

  context 'Q♠ card has appropriate values:' do
    subject(:card) {Card.new('Q', '♠')}
    it 'Q♠ card has face value of "Q"' do
      expect(card.face).to eq('Q')
    end
    it 'Q♠ card has symbol value of "♠"' do
      expect(card.symbol).to eq('♠')
    end
    it 'Q♠ card has value of 10' do
      expect(card.value).to eq(10)
    end
  end

  context 'A♣ card has appropriate values:' do
    subject(:card) {Card.new('A', '♣')}
    it 'A♣ card has face value of "A"' do
      expect(card.face).to eq('A')
    end
    it 'A♣ card has symbol value of "♣"' do
      expect(card.symbol).to eq('♣')
    end
    it 'A♣ card has value of 11' do
      expect(card.value).to eq(11)
    end
    it 'A♣ card has value of 1 after calling .value_to_1' do
      card.value_to_1
      expect(card.value).to eq(1)
    end
  end
end
