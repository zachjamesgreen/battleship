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

  def valid_coordinates(coordinates)
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
          if letter[0].ord - letter[1].ord == -1
            return true
          end
        end
      end

      if numbers.uniq.length != 1
        numbers.each_cons(2) do |number|
          if number[0].ord - number[1].ord == -1
            return true
          end
        end
      end
    end
  end

  def valid_placement?(ship, coordinates)
    if ship.length == coordinates.length
      letters = []
      numbers = []
      coordinates.each do |coordinate|
        unless @cells[coordinate].empty?
          return false
        end
        if valid_coordinate?(coordinate) == false
          return false
        end
        letters << coordinate[0]
        numbers << coordinate[1]
      end
      if letters.uniq.length == 1 || numbers.uniq.length == 1
        if letters.uniq.length != 1
          letters.each_cons(2) do |letter|
            if letter[0].ord - letter[1].ord != -1

              return false
            end
          end
          return true
        end

        if numbers.uniq.length != 1
          numbers.each_cons(2) do |number|
            if number[0].ord - number[1].ord != -1
              return false
            end
          end
          return true
        end
      end
    end
    false
  end

  def render(show_ship = false)
    string = "  1 2 3 4 \n"
    string += "A #{cells["A1"].render(show_ship)} #{cells["A2"].render(show_ship)} #{cells["A3"].render(show_ship)} #{cells["A4"].render(show_ship)} \n"
    string += "B #{cells["B1"].render(show_ship)} #{cells["B2"].render(show_ship)} #{cells["B3"].render(show_ship)} #{cells["B4"].render(show_ship)} \n"
    string += "C #{cells["C1"].render(show_ship)} #{cells["C2"].render(show_ship)} #{cells["C3"].render(show_ship)} #{cells["C4"].render(show_ship)} \n"
    string += "D #{cells["D1"].render(show_ship)} #{cells["D2"].render(show_ship)} #{cells["D3"].render(show_ship)} #{cells["D4"].render(show_ship)} \n"
    string
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end

  def create_cells
    ["A","B","C","D"].each do |letter|
       ["1","2","3","4"].each do |number|
        name = letter + number
        @cells[name] = Cell.new(name)
      end
    end
  end
end
