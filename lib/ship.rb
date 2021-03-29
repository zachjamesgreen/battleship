class Ship
  
  attr_reader :name, :length, :health
  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end

  # def health
  # end

  def sunk?
    @health == 0
  end

  def hit
    if !sunk?
      @health -= 1
    end
  end


end