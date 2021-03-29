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

    it 'method can be empty and missed' do
      cell = Cell.new("A2")
      ship = Ship.new("Cruiser", 3)
      expect(cell.render).to eq(".")
      cell.fire_upon
      expect(cell.render).to eq("M")
    end

    it 'method renders correctly' do
      cell = Cell.new("A2")
      ship = Ship.new("Cruiser", 3)
      cell.place_ship(ship)
      expect(cell.render(true)).to eq("S")
      cell.fire_upon
      ship.hit
      expect(cell.render).to eq("H")
      ship.hit
      ship.hit
      expect(cell.render).to eq("X")
    end


  end


end
