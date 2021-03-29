class Cell

  attr_reader :coordinate, :ship
  def initialize(coordinate)
    @coordinate = coordinate
  end

  def place_ship(ship)
    @ship = ship
  end

  def empty?
  end

  def fired_upon?
  end

  def fire_upon
  end

  def render
  end


end