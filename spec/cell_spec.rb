require './lib/ship.rb'
require './lib/cell.rb'

RSpec.describe 'Cell' do

  it "it exist" do
    cell = Cell.new("A2")
    expect(cell).to be_instance_of(Cell)
  end

  it "should have a coordinate" do
    cell = Cell.new("A2")
    expect(cell.coordinate).to eq("A2")
  end

  it "holds a ship" do
    cell = Cell.new("A2")
    ship = Ship.new("Cruiser", 3)
    cell.place_ship(ship)
    expect(cell.ship).to eq(ship)
  end

  describe 'methods' do

    it 'cell block is empty? - true' do
      cell = Cell.new("A2")
      ship = Ship.new("Cruiser", 3)
      expect(cell.empty?).to eq(true)
    end

    it 'cell block is empty? - false' do
      cell = Cell.new("A2")
      ship = Ship.new("Cruiser", 3)
      cell.place_ship(ship)
      expect(cell.empty?).to eq(false)
    end

    it 'cell has been fired fired upon' do
      cell = Cell.new("A2")
      ship = Ship.new("Cruiser", 3)
      cell.place_ship(ship)
      expect(cell.fired_upon?).to eq(false)
      cell.fire_upon
      expect(cell.fired_upon?).to eq(true)
    end

    it 'can hit ship' do
      cell = Cell.new("A2")
      ship = Ship.new("Cruiser", 3)
      cell.place_ship(ship)
      expect(ship.health).to eq(3)
      cell.fire_upon
      expect(ship.health).to eq(2)
    end

    it 'method can be empty and missed' do
      cell = Cell.new("A2")
      expect(cell.render).to eq(".")
      cell.fire_upon
      expect(cell.render).to eq("M")
    end

    it 'method renders correctly' do
      cell_1 = Cell.new("A1")
      cell_2 = Cell.new("A2")
      cell_3 = Cell.new("A3")
      ship = Ship.new("Cruiser", 3)
      cell_1.place_ship(ship)
      cell_2.place_ship(ship)
      cell_3.place_ship(ship)
      expect(cell_1.render(true)).to eq("S")
      cell_1.fire_upon
      expect(cell_1.render).to eq("H")
      cell_2.fire_upon
      cell_3.fire_upon
      expect(cell_1.render).to eq("X")
    end
  end

end
