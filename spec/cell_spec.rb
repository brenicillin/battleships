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

      expect(cell.coordinate).to eq("B4")
    end
    
    it 'cell has no ships' do
      cell = Cell.new("B4")

      expect(cell.ship).to eq(nil)
    end
  end
  describe '#cell can hold ships?' do
    it 'cell is empty' do
      cell = Cell.new("B4")

      expect(cell.empty?).to eq(true)
    end
    
    it 'A ship can be placed' do
      cruiser = Ship.new("Cruiser", 3)
      cell = Cell.new("B4")
      cell.place_ship(cruiser)
    
      expect(cell.ship).to be_a(Ship)
    end
    
    it 'cell is no longer empty' do
      cruiser = Ship.new("Cruiser", 3)
      cell = Cell.new("B4")
      cell.place_ship(cruiser)

      expect(cell.ship).to be_a(Ship)
      expect(cell.empty?).to eq(false)
    end
  end

  describe '#fired_upon?' do

    it 'knows when fired upon' do
      cell = Cell.new('B4')

      expect(cell.fired_upon?).to eq(false)
    end

    it 'can fire upon' do
      cell = Cell.new('B4')

      expect(cell.fired_upon?).to eq(false)

      cell.fire_upon

      expect(cell.fired_upon?).to eq(true)
    end
  end

  describe '#render' do
    it 'can render .' do
      cell = Cell.new('B4')

      expect(cell.render).to eq('.')
    end
  end

    it 'can render M for miss'
    cell = Cell.new('B4')
    cell.fire_upon

    expect(cell.render).to eq('M')
end