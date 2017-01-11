require_relative '../lib/Hand.rb'
require_relative '../lib/Card.rb'
# ♠ ♥ ♦ ♣

describe 'Hand:' do
  let(:card1) {Card.new('2', '♥')}
  let(:card2) {Card.new('A', '♣')}
  let(:card3) {Card.new('K', '♦')}
  let(:card4) {Card.new('7', '♠')}
  let(:card5) {Card.new('J', '♠')}
  subject(:hand) {Hand.new card1, card2}

  describe '#initialize:' do
    it 'card_list contains consists only of inputted cards' do
      expect(hand.card_list).to eq([card1, card2])
    end
  end

  describe '#hit_me:' do
    it 'adds a card to the hand' do
      hand.hit_me(card4)
      expect(hand.card_list).to eq([card1, card2, card4])
    end
  end

  describe '#hand_total:' do
    it "calculates hand total with number cards" do
      hand = Hand.new(card1, card4)
      expect(hand.hand_total).to eq(9)
    end

    it "calculates hand total with face cards" do
      hand = Hand.new(card3, card5)
      expect(hand.hand_total).to eq(20)
    end

    it "calculates hand total with high ace cards" do
      hand = Hand.new(card2, card4)
      expect(hand.hand_total).to eq(18)
    end

    it "calculates hand total with low ace cards" do
      hand = Hand.new(card2, card4)
      hand.hit_me(card5)
      expect(hand.hand_total).to eq(18)
    end
  end

  describe '#show_hand:' do

  end

  describe '#show_card_at:' do

  end

  describe '#check_split:' do

  end

end
