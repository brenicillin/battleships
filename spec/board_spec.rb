require 'spec_helper'

RSpec.describe Board do
  describe '#initialize' do
    it 'exists' do
      board = Board.new

      expect(board).to be_a(Board)
    end
    
    it 'has hash of cells' do
      board = Board.new

      expect(board.cells).to be_a(Hash)
    end
  end

  describe '#valid_coordinates' do
    it 'can tell if coordinate is on board' do
      board = Board.new

      expect(board.valid_coordinate?('A1')).to eq(true)
      expect(board.valid_coordinate?('D4')).to eq(true)
      expect(board.valid_coordinate?('A5')).to eq(false)
      expect(board.valid_coordinate?('E1')).to eq(false)
      expect(board.valid_coordinate?('A22')).to eq(false)
    end

    it 'can tell if placement is valid' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      submarine = Ship.new('Submarine', 2)

      expect(board.valid_placement?(cruiser, ['A1', 'A2'])).to eq('false')
      expect(board.valid_placement?(submarine, ['A2', 'A3', 'A4'])).to eq('false')
    end
  end
end