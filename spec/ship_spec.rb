require './lib/ship.rb'

RSpec.describe 'Ship' do

  it "it exist" do
    ship = Ship.new("Cruiser", 3)
    expect(ship).to be_instance_of(Ship)
  end

  it "should have a name and length" do
    ship = Ship.new("Cruiser", 3)
    expect(ship.name).to eq("Cruiser")
    expect(ship.length).to eq(3)
  end

  describe 'methods' do
    it 'should have health' do
      ship = Ship.new("Cruiser", 3)
      expect(ship.health).to eq(3)
    end

    it 'has sunk?' do
      ship = Ship.new("Cruiser", 3)
      expect(ship.sunk?).to eq(false)
      ship.hit
      ship.hit
      ship.hit
      expect(ship.sunk?).to eq(true)
    end

    it 'can be hit' do
      ship = Ship.new("Cruiser", 3)
      expect(ship.health).to eq(3)
      ship.hit
      expect(ship.health).to eq(2)
    end

    # it 'cant be hit more than the health' do
    # end
  end

end