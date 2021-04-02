require './lib/board'
require './lib/ship'
require './lib/game'
require './lib/computer_player'

RSpec.describe 'Game' do
  it 'should exist' do
    game = Game.new
    expect(game).to be_instance_of(Game)
  end

  it 'should have instance vars' do
    game = Game.new
    expect(game.player_board).to be(nil)
    expect(game.computer_board).to be(nil)
    expect(game.pc_player).to be(nil)

  end
end

RSpec.describe 'ComputerPlayer' do
  it 'should exist' do
    board = Board.new(4,4)
    pc_player = ComputerPlayer.new board
    expect(pc_player).to be_instance_of(ComputerPlayer)
  end
end
