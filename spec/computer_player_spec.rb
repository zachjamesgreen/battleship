require './lib/board'
require './lib/ship'
require './lib/computer_player'

RSpec.describe 'ComputerPlayer' do
  it 'should exist' do
    board = Board.new(4,4)
    pc_player = ComputerPlayer.new board
    expect(pc_player).to be_instance_of(ComputerPlayer)
  end

  it 'should find neighbors' do
  board = Board.new(4,4)
  pc_player = ComputerPlayer.new board
  ship = Ship.new("Cruiser", 3)
  cell_A2 = board.cells["A2"]
  cell_A1 = board.cells["A1"]
  cell_A3 = board.cells["A3"]
  cell_A3.place_ship(ship)
  expect(pc_player.find_neighbors(cell_A2, board)).to eq(["B2", "A3", "A1"])
  expect(pc_player.find_neighbors(cell_A1, board)).to eq(["B1", "A2"])
  cell_A3.fire_upon
  expect(pc_player.find_neighbors(cell_A2, board)).to eq(["B2", "A1"])
  end
end
