require './lib/board'
require './lib/cell'
require './lib/ship'

class ComputerPlayer
  attr_reader :board
  def initialize(board)
    @board = board
    place_ships
  end

  def place_ships
    # place ships randomly
    rand = Random.new
    ships = [Ship.new("Cruiser", 3), Ship.new("Sub", 2)]

    horizontal_chunks = []
    vertical_chunks = []
    horizontal = @board.cells.keys
    vertical = @board.cells.keys.sort{|a,b| a[1] <=> b[1]}


    ships.each do |ship|
      horizontal.each_cons(ship.length) do |chunk|
        horizontal_chunks << chunk
      end
      vertical.each_cons(ship.length) do |chunk|
        vertical_chunks << chunk
      end
      total_chunks = horizontal_chunks + vertical_chunks
      require 'pry'; binding.pry

      while true
        if @board.valid_placement?(ship, (coords = total_chunks.sample))
          @board.place(ship, coords)
          break
        end
      end
      # require 'pry'; binding.pry
    end







    # ships.each do |ship|
    #   while true do
    #       ship.length.times do |index|
    #         # A1
    #         coordinates << @board.cells.keys.sample
    #       end
    #       puts coordinates
    #       if @board.valid_placement?(ship, coordinates)
    #         @board.place(ship, coordinates)
    #         break
    #       end
    #     end
    # end





    # or place ships algorithmicly
  end

  def hor_or_vert

  end


end