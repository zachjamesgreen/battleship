require './lib/board'
require './lib/ship'

RSpec.describe 'Board' do
  it 'exist and has cells' do
    board = Board.new
    ship = Ship.new("Cruiser", 3)
    expect(board).to be_instance_of(Board)
    expect(board.cells).not_to be_nil
  end

  it 'should be valid coodinate' do
    board = Board.new
    ship = Ship.new("Cruiser", 3)
    expect(board.valid_coordinate?("A2")).to be true
    expect(board.valid_coordinate?("A11")).to be false

  end

  it 'should be valid placement' do
    board = Board.new
    ship = Ship.new("Cruiser", 3)
    expect(board.valid_placement?(ship,["A1", "A2"])).to be nil
    expect(board.valid_placement?(ship,["A1", "A2", "A3"])).to be nil
  end
end
