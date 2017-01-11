require_relative '../lib/Deck.rb'
# ♠ ♥ ♦ ♣

describe 'Deck:' do
  subject(:deck) {Deck.new}
  it 'contains 52 cards' do
    expect(deck.cards_remaining.length).to eq(52)
  end
  it 'contains 7♠ card' do
    card = deck.cards_remaining.find do |card|
      card.face == '7' && card.symbol == '♠'
    end
    expect(card).to be_a(Card)
  end
  it 'contains A♦ card' do
    card = deck.cards_remaining.find do |card|
      card.face == 'A' && card.symbol == '♦'
    end
    expect(card).to be_a(Card)
  end

  describe '#draw_card:' do
    before(:each) do
      @deck = deck
      @card = @deck.draw_card
    end
    it 'returns a card object' do
      expect(@card).to be_a(Card)
    end
    it 'deck has 51 cards after drawing a card' do
      expect(@deck.cards_remaining.length).to eq(51)
    end
    it 'drawn card is removed from deck' do
      expect(@deck.cards_remaining).not_to include(@card)
    end
  end
end
