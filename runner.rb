require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'

game = Game.new

player_cruiser = Ship.new("Cruiser", 3)
player_sub = Ship.new("Sub", 2)
computer_cruiser = Ship.new("Cruiser", 3)
computer_sub = Ship.new("Sub", 2)

game.start
