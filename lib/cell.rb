class Cell
  attr_reader :fired_upon,
              :ship,
              :coordinate

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
      # if @ship != nil
      #   ship.health -= 1
      # end
  end

  def fired_upon?
    @fired_upon
  end

  def render(*)
    if @ship == nil && @fired_upon == false
      p '.'
      # require 'pry'; binding.pry
    elsif @ship != nil 
      p 'S'
    # elsif
    end
  end
end