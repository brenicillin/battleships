class Board
  attr_reader :cells,
              :vertical_cells,
              :horizontal_cells

  def initialize
    @cells = {
      'A1'=>Cell.new('A1'),
      'A2'=>Cell.new('A2'),
      'A3'=>Cell.new('A3'),
      'A4'=>Cell.new('A4'),
      'B1'=>Cell.new('B1'),
      'B2'=>Cell.new('B2'),
      'B3'=>Cell.new('B3'),
      'B4'=>Cell.new('B4'),
      'C1'=>Cell.new('C1'),
      'C2'=>Cell.new('C2'),
      'C3'=>Cell.new('C3'),
      'C4'=>Cell.new('C4'),
      'D1'=>Cell.new('D1'),
      'D2'=>Cell.new('D2'),
      'D3'=>Cell.new('D3'),
      'D4'=>Cell.new('D4'),
    }
    @horizontal_cells = [['A1', 'A2', 'A3', 'A4'],['B1','B2','B3','B4'],['C1','C2','C3','C4'],['D1','D2','D3','D4']]
    @vertical_cells = [['A1','B1','C1','D1'],['A2','B2','C2','D2'],['A3','B3','C3','D3'],['A4','B4','C4','D4']]
  end
  
  def valid_placement?(ship, coordinates)
    if ship.length == coordinates.length && validate_cell(coordinates)
      coordinates_consecutive_horizontal?(coordinates) || coordinates_consecutive_vertical?(coordinates)
    else false
    end
  end
  
  def place(ship, ship_coordinates)
    if valid_placement?(ship, ship_coordinates) && validate_cell(ship_coordinates)
      ship_coordinates.each do |cell|
        cells[cell].place_ship(ship)
      end
    else false
    end
  end
  
  def render(view = false)
    if view == true
      rendered_true
    else
      rendered
    end
  end
  
  #helper methods
  
  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end
  
  def rendered_true
    "  1 2 3 4 \n" +
    "A #{@cells["A1"].render(true)} #{@cells["A2"].render(true)} #{@cells["A3"].render(true)} #{@cells["A4"].render(true)}\n" +
    "B #{@cells["B1"].render(true)} #{@cells["B2"].render(true)} #{@cells["B3"].render(true)} #{@cells["B4"].render(true)}\n" +
    "C #{@cells["C1"].render(true)} #{@cells["C2"].render(true)} #{@cells["C3"].render(true)} #{@cells["C4"].render(true)}\n" +
    "D #{@cells["D1"].render(true)} #{@cells["D2"].render(true)} #{@cells["D3"].render(true)} #{@cells["D4"].render(true)}"
  end
  
  def rendered
    "  1 2 3 4 \n" +
    "A #{@cells["A1"].render} #{@cells["A2"].render} #{@cells["A3"].render} #{@cells["A4"].render}\n" +
    "B #{@cells["B1"].render} #{@cells["B2"].render} #{@cells["B3"].render} #{@cells["B4"].render}\n" +
    "C #{@cells["C1"].render} #{@cells["C2"].render} #{@cells["C3"].render} #{@cells["C4"].render}\n" +
    "D #{@cells["D1"].render} #{@cells["D2"].render} #{@cells["D3"].render} #{@cells["D4"].render}"
  end
  
  def validate_cell(ship_coordinates)
    ship_coordinates.each.all? do |cell|
      return false unless valid_coordinate?(cell)
      cells[cell].empty?
    end
  end

  def coordinates_consecutive_horizontal?(coordinates)
    if @horizontal_cells[0].each_cons(coordinates.length).any? do |cells|
       coordinates == cells
      end
        true
      elsif @horizontal_cells[1].each_cons(coordinates.length).any? do |cells|
        coordinates == cells
      end
        true
      elsif @horizontal_cells[2].each_cons(coordinates.length).any? do |cells|
        coordinates == cells
      end
        true
      elsif @horizontal_cells[3].each_cons(coordinates.length).any? do |cells|
        coordinates == cells
      end
        true
      else 
        false
    end
  end

  def coordinates_consecutive_vertical?(coordinates)
    if @vertical_cells[0].each_cons(coordinates.length).any? do |cells|
        coordinates == cells
      end
      true
      elsif @vertical_cells[1].each_cons(coordinates.length).any? do |cells|
      coordinates == cells
      end
      true
      elsif @vertical_cells[2].each_cons(coordinates.length).any? do |cells|
      coordinates == cells
      end
      true
      elsif @vertical_cells[3].each_cons(coordinates.length).any? do |cells|
        coordinates == cells
      end
      true
      else 
        false
    end
  end

  def valid_cruiser_placements 
      [
      %w(A1 B1 C1),
      %w(B1 C1 D1),
      %w(A2 B2 C2),
      %w(B2 C2 D2),
      %w(A3 B3 C3),
      %w(B3 C3 D3),
      %w(A4 B4 C4),
      %w(B4 C4 D4),
      %w(A1 A2 A3),
      %w(A2 A3 A4),
      %w(B1 B2 B3),
      %w(B2 B3 B4),
      %w(C1 C2 C3),
      %w(C2 C3 C4),
      %w(D1 D2 D3),
      %w(D2 D3 D4)
    ]
  end
  
  def valid_submarine_placements
    [
        %w(A1 B1),
        %w(B1 C1),
        %w(C1 D1),
        %w(A2 B2),
        %w(B2 C2),
        %w(C2 D2),
        %w(A3 B3),
        %w(B3 C3),
        %w(C3 D3),
        %w(A4 B4),
        %w(B4 C4),
        %w(C4 D4),
        %w(A1 A2),
        %w(A2 A3),
        %w(A3 A4),
        %w(B1 B2),
        %w(B2 B3),
        %w(B3 B4),
        %w(C1 C2),
        %w(C2 C3),
        %w(C3 C4),
        %w(D1 D2),
        %w(D2 D3),
        %w(D3 D4)
      ]
  end
end