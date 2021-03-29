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

  def valid_placement?
  end




  def create_cells
    ["A","B","C","D"].each do |letter|
      ["1","2","3","4"].each do |number|
        name = letter+number
        @cells[name] = Cell.new(name)
      end
    end 
  end
end