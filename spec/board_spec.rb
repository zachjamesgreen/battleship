require './lib/board'

RSpec.describe 'Board' do
  it 'exist and has cells' do 
    board = Board.new
    expect(board).to be_instance_of(Board)
    expect(board.cells).not_to be_nil
  end

  it 'should be valid coodinate' do
    board = Board.new
    expect(board.valid_coordinate?("A2")).to be true
    expect(board.valid_coordinate?("A11")).to be false

  end
end