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

  expect(pc_player.find_neighbors("A2")).to eq(["B2", "A3", "A1"])
  expect(pc_player.find_neighbors("A1")).to eq(["B1", "A2"])
  end
end
