class Board
  attr_reader :cells

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
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def valid_placement?(ship, ship_coordinates)
    if ship.length == ship_coordinates.length
      if ship.length == 3
        valid_cruiser_placements.include?(ship_coordinates)
      elsif ship.length == 2
        valid_submarine_placements.include?(ship_coordinates)
      end
    else false
    end
  end











  #helper methods
  
  def valid_cruiser_placements 
    valid_placements_c = [
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
    valid_placements_s = [
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