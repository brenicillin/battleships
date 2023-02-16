require 'rspec'
require './lib/cell'
require './lib/ship'

RSpec.describe do
  describe '#initilaize' do
    it 'cell exists' do
      cell = Cell.new("B4")

      expect(cell).to be_a(Cell)
    end
    
    it 'cell has coordinates' do
      cell = Cell.new("B4")

      expect(cell.coordinate).to be_a("B4")
    end
    
    it 'cell has no ships' do
      cell = Cell.new("B4")

      expect(cell.ship).to be_a(nil)
    end
  end
  describe '#cell can hold ships?' do
    it 'cell is empty' do
      cell = Cell.new("B4")

      expect(cell.empty?).to be_a(true)
    end
    
    it 'A ship can be placed' do
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    
      expect(cell.ship).to eq(Ship)
    end
    
    it 'cell is no longer empty' do
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.ship).to eq(Ship)
      expect(cell.empty?).to eq(false)
    end
  end
end