require 'securerandom'

RSpec.describe Quadtree::AxisAlignedBoundingBox do
  before :all do
    @center = create_random_point
    @half_dim = SecureRandom.random_number 100.0
    @aabb = Quadtree::AxisAlignedBoundingBox.new(@center, @half_dim)
    @getaboden = create_point_getaboden
    @mattssons = create_point_mattssons
    @aabb_getaboden = create_aabb_getaboden
    @aabb_mattssons = create_aabb_mattssons
    @aabb_getaboden_small = create_aabb_getaboden_small
    @aabb_mattssons_small = create_aabb_mattssons_small
  end

  it "has the correct type" do
    expect(@aabb).not_to be nil
    expect(@aabb).to be_a Quadtree::AxisAlignedBoundingBox
  end

  it "has a center point" do
    expect(@aabb.center).not_to be nil
    expect(@aabb.center).to be_a Quadtree::Point
    expect(@aabb.center).to eq @center
  end

  it "has dimensions" do
    expect(@aabb.half_dimension).not_to be nil
    expect(@aabb.half_dimension).to be_a Float
    expect(@aabb.half_dimension).to eq @half_dim
  end

  it "actually contains its center point" do
    expect(@aabb.contains_point?(@center)).to eq true
    expect(@aabb_mattssons.contains_point?(@mattssons)).to eq true
    expect(@aabb_getaboden.contains_point?(@getaboden)).to eq true
  end

  it "can check for intersections" do
    puts @aabb_getaboden.intersects?(@aabb_mattssons)
    puts @aabb_getaboden_small.intersects?(@aabb_mattssons_small)
  end
end
