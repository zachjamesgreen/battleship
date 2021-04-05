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

      total_chunks.shuffle!

      total_chunks.each do |coords|
        if @board.valid_placement?(ship, coords)
          @board.place(ship, coords)
          break
        end
      end
    end
  end

  def find_neighbors(cell)
    array = []
    array << (((cell[0].ord + 1).chr) + cell[1])
    array << (((cell[0].ord - 1).chr) + cell[1])
    array << (cell[0] + (cell[1].to_i + 1).to_s)
    array << (cell[0] + (cell[1].to_i - 1).to_s)
    array.select! do |coordinate|
      @board.valid_coordinate?(coordinate)
    end
    # require'pry';binding.pry
  end

  def get_player_board(player_board)
    @shots = player_board.cells.keys
  end

  def computer_takes_shot(player_board)
    until player_board.valid_coordinate?(shot = @shots.sample) == true
      loop
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
        @next_shot = find_neighbors(shot)
      else cell.render == "X"
        p  "My shot was on #{shot} and I sunk your ship!"
      end
    end
  end

end
