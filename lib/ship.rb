class Ship
  attr_accessor :health
  attr_reader   :name, :length

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end

  def sunk?
    @health.zero?
  end

  def hit
    @health -= 1
  end
end