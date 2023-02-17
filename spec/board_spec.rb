require 'spec_helper'

RSpec.describe Board do
  describe '#initialize' do
    it 'exists' do
      board = Board.new

      expect(board).to be_a(Board)
    end
    
    it 'has hash of cells'
      board = Board.new

      expect(board.cells).to be_a(Hash)
  end
end