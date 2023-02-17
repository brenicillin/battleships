require 'spec_helper'

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
    xit 'can render .' do
      cell = Cell.new('B4')

      expect(cell.render).to eq('.')
      expect(cell.render(true)).to eq('S')
    end

    xit 'can render M for miss' do
    cell = Cell.new('B4')
    cell.fire_upon

    expect(cell.render).to eq('M')
    end

    xit 'can render H for hit' do
      cruiser = Ship.new('Cruiser', 3)
      cell = Cell.new('B4')
      cell.place_ship(cruiser)

      expect(cell.render).to eq('.')
      
      cell.fire_upon
      
      expect(cell.render).to eq('H')
    end

    xit 'can render X for sunken ship' do
      cruiser = Ship.new('Cruiser', 3)
      cell_1 = Cell.new('B2')
      cell_2 = Cell.new('B3')
      cell_3 = Cell.new('B4')
      cell_1.place_ship(cruiser)
      cell_2.place_ship(cruiser)
      cell_3.place_ship(cruiser)

      expect(cell_1.render).to eq('X')
      expect(cell_2.render).to eq('X')
      expect(cell_3.render).to eq('X')
    end
  end
end