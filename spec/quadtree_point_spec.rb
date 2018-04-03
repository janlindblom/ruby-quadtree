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
end
