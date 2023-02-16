class Cell
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
  end

  def empty?
    @ship == nil
  end
end