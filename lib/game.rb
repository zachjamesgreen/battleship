require "./lib/computer_player"
class Game
  attr_reader :player_board, :computer_board
  def initialize()
    @player_board = Board.new
    @computer_board = Board.new
  end

  def start

    response = greet
    if response == "p"
      place_ships
      create_computer_player
    elsif  response == "q"
      puts "Bye"
    else
      puts "Enter valid response"
      start
    end
    while game_over
      display_board
      var = gets.chomp # shoot method
      puts var
    end
  end

  def game_over
    @player_board.cells.each do |key, cell|
      if !cell.empty? && cell.ship.sunk?
        return true
      end
    end
    @computer_board.cells.each do |key, cell|
      if !cell.empty? && cell.ship.sunk?
        return true
      end
    end
  end

  def greet
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    gets.chomp.downcase
  end

  def place_ships
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render
    puts "Enter the squares for the Cruiser (3 spaces):"


    player_cruiser = Ship.new("Cruiser", 3)
    player_sub = Ship.new("Sub", 2)

    place_ship(player_cruiser, gets.chomp)
    place_ship(player_sub, gets.chomp)


    puts @player_board.render(true)

  end

  def place_ship(ship, coords)
    puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
    coords_array = coords.upcase.split(" ")
    if @player_board.valid_placement?(ship, coords_array)

      @player_board.place(ship, coords_array)
      @player_board.render(true)
      # require 'pry'; binding.pry
    else
      puts "Those are invalid coordinates. Please try again:"
      place_ship(ship, gets.chomp)
    end
  end

  def create_computer_player
    pc_player = ComputerPlayer.new(@computer_board)
    @computer_board.render(true)
  end


  def display_board
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)

  end
end