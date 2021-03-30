require './lib/cell'
class Board
  attr_reader :cells
  def initialize()
    @cells = {}
    create_cells
  end

  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    if ship.length == coordinates.length
      coordinates.each do |coordinate|
        if valid_coordinate?(coordinate) == false
          return false
        end
      end
      letters_variable = []
      numbers_variable = []
      coordinates.each do |coordinate|
        letters_variable << coordinate[0]
        numbers_variable << coordinate[1]
      end
      if letters_variable.uniq || numbers_variable.uniq == false
        return false
      end  
      require 'pry';binding.pry
    end

  end

# coordinate @cells.keys[0][0] && 1,2,3
# coordinate cells.keys[0][1] && A,B,C


  def create_cells
    ["A","B","C","D"].each do |letter|
      ["1","2","3","4"].each do |number|
        name = letter+number
        @cells[name] = Cell.new(name)
      end
    end
  end
end
