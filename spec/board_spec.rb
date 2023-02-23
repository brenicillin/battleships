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

    it 'can tell if placement is not valid' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      submarine = Ship.new('Submarine', 2)
      
      expect(board.valid_placement?(cruiser, ['A1', 'A2'])).to eq(false)
      expect(board.valid_placement?(submarine, ['A2', 'A3', 'A4'])).to eq(false)
    end
    
    it 'can tell if coordinates are consecutive' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      submarine = Ship.new('Submarine', 2)
      
      expect(board.valid_placement?(cruiser, ['A1', 'A2', 'A4'])).to eq(false)
      expect(board.valid_placement?(submarine, ['A1', 'C1'])).to eq(false)
      expect(board.valid_placement?(cruiser, ['A3', 'A2', 'A1'])).to eq(false)
      expect(board.valid_placement?(submarine, ['C1', 'B1'])).to eq(false)
    end
    
    it 'can tell if coordinates are diagonal' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      submarine = Ship.new('Submarine', 2)
    
      expect(board.valid_placement?(cruiser, ['A1', 'B2', 'C3'])).to eq(false)
      expect(board.valid_placement?(submarine, ['C2', 'D3'])).to eq(false)
    end
    
    it 'can tell if placement is valid' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      submarine = Ship.new('Submarine', 2)

      expect(board.valid_placement?(submarine, ['A1', 'A2'])).to eq(true)
      expect(board.valid_placement?(cruiser, ['B1', 'C1', 'D1'])).to eq(true)
    end
  end

  describe '#place ships' do
    it 'can contain single ship in multiple cells' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      cell_1 = board.cells['A1']
      cell_2 = board.cells['A2']
      cell_3 = board.cells['A3']
      board.place(cruiser, ['A1', 'A2', 'A3'])

      expect(cell_1.ship).to eq(cruiser)
      expect(cell_2.ship).to eq(cruiser)
      expect(cell_3.ship).to eq(cruiser)
      expect(cell_1.ship == cell_2.ship).to eq(true)
      expect(cell_2.ship == cell_3.ship).to eq(true)
    end

    it 'cant overwrite other ships' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      submarine = Ship.new('Submarine', 2)
      board.place(cruiser, ['A1', 'A2', 'A3'])

      expect(board.valid_placement?(submarine, ['A1', 'B1'])).to eq(false)
    end
  end
  
  describe '#render' do
    it 'board can haz render' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      board.place(cruiser, ['A1', 'A2', 'A3'])

      expect(board.render).to be_a(String)
      expect(board.render(true)).to be_a(String)
    end
  end

  describe '#helper methods' do
    it 'can ensure coordinates are valid vertically and horizontally' do
      board = Board.new

      expect(board.coordinates_consecutive_vertical?(['A1', 'B1', 'C1'])).to eq(true)
      expect(board.coordinates_consecutive_horizontal?(['A1', 'A2', 'A3'])).to eq(true)
      expect(board.coordinates_consecutive_vertical?(['A1', 'A3', 'A4'])).to eq(false)
      expect(board.coordinates_consecutive_horizontal?(['A1', 'C2', 'D2'])).to eq(false)

      expect(board.coordinates_consecutive_vertical?(['A1', 'B1'])).to eq(true)
      expect(board.coordinates_consecutive_horizontal?(['A1','A2'])).to eq(true)
      expect(board.coordinates_consecutive_vertical?(['A1', 'B2'])).to eq(false)
      expect(board.coordinates_consecutive_horizontal?(['B1', 'B3'])).to eq(false)
    end

    it 'creates array of valid cruiser placements' do
      board = Board.new

      expect(board.valid_cruiser_placements).to be_a(Array)
      expect(board.valid_cruiser_placements.length).to eq(16)
    end

    it 'creates array of valid submarine placements' do
      board = Board.new
      
      expect(board.valid_submarine_placements).to be_a(Array)
      expect(board.valid_submarine_placements.length).to eq(24)
    end

    it 'can validate cell placement' do
        board = Board.new
        cruiser = Ship.new('Cruiser', 3)
        submarine = Ship.new('Submarine', 2)
        board.place(cruiser, ['A1', 'A2', 'A3'])

        expect(board.validate_cell(['A1', 'B1', 'C1'])).to eq(false)
        expect(board.validate_cell(['A1', 'A2', 'A3'])).to eq(false)
        expect(board.validate_cell(['C1', 'D1', 'E1'])).to eq(false)
        expect(board.validate_cell(['A4', 'B4', 'VB'])).to eq(false)
        expect(board.validate_cell(['B1', 'B2', 'B3'])).to eq(true)
    end
  end
end