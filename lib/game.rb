require "awesome_print"
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

    elsif  response == "q"
      puts "Bye"
    else
      puts "Enter valid response"
      start
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
    coords = gets.chomp
    player_cruiser = Ship.new("Cruiser", 3)
    player_sub = Ship.new("Sub", 2)
    player_board.place(player_cruiser, coords.upcase.split(" "))
    puts @player_board.render(true)
    puts "Enter the squares for the Sub (2 spaces):"
    coords = gets.chomp
    player_board.place(player_sub, coords.upcase.split(" "))
    puts @player_board.render(true)

  end
end