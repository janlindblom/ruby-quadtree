require 'securerandom'

RSpec.describe Quadtree::Point do
  before :all do
    @point = create_random_point
    @integer_point = create_random_integer_point
    @getaboden = create_point_getaboden
    @mattssons = create_point_mattssons
  end

  it "has the correct type" do
    expect(@point).not_to be nil
    expect(@point).to be_a Quadtree::Point
  end

  it "has an X coordinate" do
    expect(@point.x).to be_a Float
    expect(@integer_point.x).to be_a Integer
  end

  it "has a Y coordinate" do
    expect(@point.y).to be_a Float
    expect(@integer_point.y).to be_a Integer
  end

  it "can carry a payload" do
    expect(@point.respond_to?(:data)).to be true
  end

  it "can find the general distance to another point" do
    expect(@mattssons.distance_to(@getaboden)).to eq 0.20302915250771117
    expect(@mattssons.distance_to(@getaboden)).to be_a Float
  end

  it "can find the (approximate) haversine distance to another point (in metres)" do
    expect(@mattssons.haversine_distance_to(@getaboden)).to be_a Float
    expect(@mattssons.haversine_distance_to(@getaboden)).to eq 17888.088005906367
  end

  it "can interpret numbers in strings" do
    p1 = Quadtree::Point.new "12", "23"
    p2 = Quadtree::Point.new "12.23", "23.45"
    expect(p1).to be_a Quadtree::Point
    expect(p1.x).to eq 12
    expect(p1.y).to eq 23
    expect(p2).to be_a Quadtree::Point
    expect(p2.x).to eq 12.23
    expect(p2.y).to eq 23.45
  end

  it "will raise an UnknownTypeError if input is not numeric" do
    expect{ Quadtree::Point.new("a", "b") }.to raise_error Quadtree::UnknownTypeError
  end
end
