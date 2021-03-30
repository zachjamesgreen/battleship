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
      letters = []
      numbers = []
      coordinates.each do |coordinate|
        if valid_coordinate?(coordinate) == false
          return false
        end
        letters << coordinate[0]
        numbers << coordinate[1]
      end
      if letters.uniq.length == 1 || numbers.uniq.length == 1
        if letters.uniq.length != 1
          letters.each_cons(2) do |letter|
            # require 'pry'; binding.pry
            if letter[0].ord - letter[1].ord == 1 || letter[0].ord - letter[1].ord == -1
              return true
            end
          end
        end

        if numbers.uniq.length != 1
          numbers.each_cons(2) do |number|
            # require 'pry'; binding.pry
            if number[0].ord - number[1].ord == 1 || number[0].ord - number[1].ord == -1
              return true
            end
          end
        end


      end
    end
    false
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
