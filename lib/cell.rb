class Cell
  attr_reader :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    @fired_upon = true
  end

  def fired_upon?
    @fired_upon
  end
end