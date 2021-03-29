require './lib/ship.rb'
require './lib/cell.rb'


RSpec.describe 'Cell' do
  it "it exist" do
    cell = Cell.new("A2")
    expect(cell).to be_instance_of(Cell)
  end

  
end