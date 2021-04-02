class Cell

  attr_reader :coordinate, :ship, :hit
  
  def initialize(coordinate)
    @coordinate = coordinate
    @hit = false
  end

  def place_ship(ship)
    @ship = ship
  end

  def empty?
    @ship == nil
  end

  def fired_upon?
    @hit
  end

  def fire_upon
    if !fired_upon? && !empty? && @ship.health != 0
      @ship.hit
    end
    @hit = true
  end

  def render(show_ship = false)
    if @hit && empty?
      "M"
    elsif @hit && @ship.health == 0
      "X"
    elsif @hit
      "H"
    elsif show_ship == true && !empty?
      "S"
    else
      "."
    end
  end

end
