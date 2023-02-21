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
    # @ship == nil
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    @fired_upon = true
    if !@ship.nil?
      ship.hit
    end
  end

  def fired_upon?
    @fired_upon
  end

  def render(view = false)
    if view == true && !@ship.nil? && @fired_upon == false
      'S'
    elsif @ship.nil? && @fired_upon == true
      'M'
    elsif !@ship.nil? && @fired_upon == true
      if @ship.sunk?
        'X'
      else
        'H'
      end
    else @fired_upon == false
        '.'
    end
  end
end