require 'spec_helper'
require_relative '../lib/hangman.rb'

describe 'hangman_printer' do
  context 'for the word "car"' do
    it 'prints all blanks when array is empty' do
      expect(puzzle('car')).to eq('_ _ _')
    end

    it 'prints all a when array = ["a"]' do
      expect(puzzle('car', ['a'])).to eq('_ a _')
    end

    it 'prints full word car' do
      expect(puzzle('car', ['a','r','c'])).to eq('c a r')
    end

    it 'prints a and r but not d' do
      expect(puzzle('car', ['a','r','d'])).to eq('_ a r')
    end

    it 'doesnt print d' do
      expect(puzzle('car', ['a','r','d'])).to_not include('d')
    end
  end

  context 'for the word "home"' do
    it 'prints all blanks when array is empty' do
      expect(puzzle('home')).to eq('_ _ _ _')
    end

    it 'prints all a when array = ["a"]' do
      expect(puzzle('home', ['o'])).to eq('_ o _ _')
    end

    it 'prints full word home' do
      expect(puzzle('home', ['h','o','m', 'f', 'e', 'o'])).to eq('h o m e')
    end

    it 'prints h, m and e but not o' do
      expect(puzzle('home', ['h','e','m'])).to eq('h _ m e')
    end

    it 'doesnt print d' do
      expect(puzzle('home', ['a','r','d'])).to_not include('d')
    end
  end
end
