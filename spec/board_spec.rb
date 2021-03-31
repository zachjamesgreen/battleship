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
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    # Testing Cruiser
    expect(board.valid_placement?(cruiser,["A1", "B1", "C1"])).to be true
    # Testing length
    expect(board.valid_placement?(cruiser,["A1", "A2"])).to be false
    expect(board.valid_placement?(cruiser,["A1", "A2", "A3", "A4"])).to be false
    # Testing diagonal
    expect(board.valid_placement?(cruiser,["A1", "B2", "C3"])).to be false

    # Test backwards is false
    expect(board.valid_placement?(cruiser,["A3", "A2", "A1"])).to be false

    # Testing sub
    expect(board.valid_placement?(submarine,["A1", "B1"])).to be true
    # Testing length
    expect(board.valid_placement?(submarine,["A1"])).to be false
    expect(board.valid_placement?(submarine,["A1", "A2", "A3"])).to be false
    # Testing diagonal
    expect(board.valid_placement?(submarine,["A1", "B2"])).to be false
  end

  it 'can be rendered' do
    board = Board.new
    rendered_board = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    expect(board.render).to eq(rendered_board)
  end

  it 'can be placed' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    rendered_board = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
    expect(board.render(true)).to eq(rendered_board)
    board.cells["A1"].fire_upon
    rendered_board = "  1 2 3 4 \nA H . . . \nB . . . . \nC . . . . \nD . . . . \n"
    expect(board.render).to eq(rendered_board)
    board.cells["A2"].fire_upon
    board.cells["A3"].fire_upon
    rendered_board = "  1 2 3 4 \nA X X X . \nB . . . . \nC . . . . \nD . . . . \n"
    expect(board.render).to eq(rendered_board)
    board.cells["D3"].fire_upon
    rendered_board = "  1 2 3 4 \nA X X X . \nB . . . . \nC . . . . \nD . . M . \n"
    expect(board.render).to eq(rendered_board)
  end
end
