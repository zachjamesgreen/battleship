require './lib/board'
require './lib/cell'
require './lib/ship'

class ComputerPlayer
  attr_reader :board
  def initialize(board)
    @board = board
    @next_shots = []
  end

  def place_ships(ships)

    # place ships randomly
    rand = Random.new
    # ships = [Ship.new("Cruiser", 3), Ship.new("Sub", 2)]

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

      total_chunks.shuffle!

      total_chunks.each do |coords|
        if @board.valid_placement?(ship, coords)
          @board.place(ship, coords)
          break
        end
      end
    end
  end

  def find_neighbors(cell, player_board)
    array = []
    cells_array = []
    array << (((cell.coordinate[0].ord + 1).chr) + cell.coordinate[1])
    array << (((cell.coordinate[0].ord - 1).chr) + cell.coordinate[1])
    array << (cell.coordinate[0] + (cell.coordinate[1].to_i + 1).to_s)
    array << (cell.coordinate[0] + (cell.coordinate[1].to_i - 1).to_s)
    array.select! do |coordinate|
      @board.valid_coordinate?(coordinate)
      # require'pry';binding.pry
    end
    array.each do |coordinate|
      if player_board.cells[coordinate].fired_upon? == false
        cells_array << coordinate
      end
    end
    cells_array
  end

  def get_player_board(player_board)
    @shots = player_board.cells.keys
  end

  def computer_takes_shot(player_board)
    if @next_shots.empty?
      until player_board.valid_coordinate?(shot = @shots.sample) == true
        loop
      end
      @shots.delete(shot)
    else
      until player_board.valid_coordinate?(shot = @next_shots.sample) == true
        loop
      end
      @next_shots.delete(shot)
    end
    cell = player_board.cells[shot]
    if player_board.cells[shot].fired_upon?
      computer_takes_shot(player_board)
    else
      cell.fire_upon
      if cell.render == "M"
        p "My shot on #{shot} was a miss."
      elsif cell.render == "H"
        p "My shot on #{shot} was a hit!"
        @next_shots = find_neighbors(cell, player_board)
      else cell.render == "X"
        p  "My shot was on #{shot} and I sunk your ship!"
        @next_shots = []
      end
    end
  end

end
