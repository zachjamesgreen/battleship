require "./lib/computer_player"

class Game

  attr_reader :player_board, :computer_board, :pc_player
  
  def initialize()
    @player_board = nil
    @computer_board = nil
    @pc_player = nil
    @game_over = true
  end

  def start
    response = greet
    if response == "p"
      board_size
      place_ships
    elsif  response == "q"
      puts "Bye"
      return
    else
      puts "Enter valid response"
      start
    end
    while @game_over
      display_board
      take_turn
    end
    start
  end

  def board_size
    puts "Choose the width of your board with a max of 9:"
    width = gets.chomp.to_i
    puts "Choose the height of your board with a max of 26:"
    height = gets.chomp.to_i
    create_players(width, height)
  end

  def create_players(width, height)
    @player_board = Board.new(width, height)
    @computer_board = Board.new(width, height)
    @pc_player = ComputerPlayer.new(@computer_board)
    @pc_player.get_player_board(@player_board)
  end

  def check_for_winner
    computer_board_ships = @computer_board.cells.select do |key, value|
      value.ship != nil
    end
    player_board_ships = @player_board.cells.select do |key, value|
      value.ship != nil
    end
    computer_health = computer_board_ships.values.sum do |cell|
      cell.ship.health
    end
    player_health = player_board_ships.values.sum do |cell|
      cell.ship.health
    end

    if computer_health > 0 && player_health > 0
      @game_over = true
    elsif computer_health == 0
      p "You won!"
      @game_over = false
    elsif player_health == 0
      p "I won!"
      @game_over = false
    end
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render(true)
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
  end

  def take_turn
    puts "Enter the coordinate for your shot:"
    until @computer_board.valid_coordinate?(shot = gets.chomp.upcase)
      puts "Please enter a valid coordinate:"
    end
    cell = @computer_board.cells[shot]
    if @computer_board.cells[shot].fired_upon?
      puts "You have already chosen this square. Please choose another."
      take_turn
    else
      cell.fire_upon
      if cell.render == "M"
        p "Your shot on #{shot} was a miss."
      elsif cell.render == "H"
        p "Your shot on #{shot} was a hit!"
      else cell.render == "X"
        p "Your shot was on #{shot} and you sunk my ship!"
      end
      if check_for_winner == false
        return
      end
      @pc_player.computer_takes_shot(@player_board)
      check_for_winner
    end
  end

  def greet
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    gets.chomp.downcase
  end

  def place_ships
    puts "Would you like to create your own ships?(Y for yes, N for no)"
    create_option = gets.chomp.upcase
    if create_option == "Y"
      puts "Great! Lets's get started!"
      puts "How many ships would you like to create?"
      number_of_ships = gets.chomp.to_i
      if number_of_ships > @player_board.height
        max_ships = @player_board.height - 2
      elsif  number_of_ships > @player_board.width
        max_ships = @player_board.width - 2
      else
        max_ships = @player_board.width
      end
      if number_of_ships > max_ships
        number_of_ships = max_ships
        puts "The max number of ships for you board is #{max_ships}. Let's get them placed!"
      end
      ships_array = []
      number_of_ships.times do
        puts "What would you like to name your ship?"
        name = gets.chomp
        puts "What is the length of your ship?"
        length = nil
        loop do
          length = gets.chomp.to_i
          if (length <= @player_board.width || length <= @player_board.height) && length.is_a?(Integer) && length > 0
            break
          end
          puts "That ship is too long for your board or not valid. Please try again."
        end
        puts @player_board.render(true)
        place_ship(Ship.new(name, length))
        ships_array << Ship.new(name, length)
      end
    elsif create_option == "N"
      puts "I have laid out my ships on the grid."
      puts "You now need to lay out your two ships."
      puts "The Cruiser is three units long and the Submarine is two units long."
      puts @player_board.render
      player_cruiser = Ship.new("Cruiser", 3)
      player_sub = Ship.new("Sub", 2)
      ships_array = [Ship.new("Cruiser", 3), Ship.new("Sub", 2)]
      place_ship(player_cruiser)
      place_ship(player_sub)
      puts @player_board.render(true)
    end
    @pc_player.place_ships(ships_array)
  end

  def place_ship(ship)
    puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
    coords_array = gets.chomp.upcase.split(" ")
    if @player_board.valid_placement?(ship, coords_array)

      @player_board.place(ship, coords_array)
      @player_board.render(true)
    else
      puts "Those are invalid coordinates. Please try again:"
      place_ship(ship)
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
