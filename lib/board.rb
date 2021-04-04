require './lib/cell'

class Board

  attr_reader :cells, :height, :width

  def initialize(width, height)
    @width = width # Numbers
    @height = height # Letters
    @cells = {}
    @letters_array = ("A".."Z").to_a[0..height-1]
    @numbers_array = (1..9).to_a[0..width-1]
    create_cells
  end

  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    if ship.length != coordinates.length
      return false
    end
    letters = []
    numbers = []
    coordinates.each do |coordinate|
      unless @cells[coordinate] && @cells[coordinate].empty?
        return false
      end
      if valid_coordinate?(coordinate) == false
        return false
      end
      letters << coordinate[0]
      numbers << coordinate[1]
    end
    return check_letters_and_numbers(letters, numbers)
  end

  def check_letters_and_numbers(letters, numbers)
    check = false
    if letters.length == 1
      return true
    end
    if letters.uniq.length == 1 || numbers.uniq.length == 1
      if letters.uniq.length != 1
        letters.each_cons(2) do |letter|
          if letter[0].ord - letter[1].ord != -1
            return false
          end
        end
        check = true
      end
      if numbers.uniq.length != 1
        numbers.each_cons(2) do |number|
          if number[0].ord - number[1].ord != -1
            return false
          end
        end
        check = true
      end
    end
    return check
  end


  def render(show_ship = false)
    string = "  #{@numbers_array.join(" ")} \n"

    @letters_array.length.times do |i|
      string += "#{@letters_array[i]} "
      @numbers_array.length.times do |j|
        name = @letters_array[i]+@numbers_array[j].to_s
        string += "#{cells["#{name}"].render(show_ship)} "
      end
      string += "\n"
    end

    string
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end


  def create_cells
    @letters_array.each do |letter|
      @numbers_array.each do |number|
        name = letter + number.to_s
        @cells[name] = Cell.new(name)
      end
    end
  end

end
