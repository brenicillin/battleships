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
    if @ship != nil
      ship.hit
    end
  end

  def fired_upon?
    @fired_upon
  end

  def render(player = false)
    if player = true && !@ship.nil? && @fired_upon == false
      p 'S'
    elsif @ship.nil? && @fired_upon == true
      p 'M'
    elsif !@ship.nil? && @fired_upon == true
      if @ship.sunk?
        p 'X'
      else
        p 'H'
      end
    else @fired_upon == false
        p '.'
      end
    end
end