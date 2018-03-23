require 'securerandom'

RSpec.describe Quadtree::Quadtree do
  before :all do
    @center = create_random_point
    @half_dim = SecureRandom.random_number 100.0
    @qt = Quadtree::Quadtree.new(create_random_aabb)
    @getaboden = create_point_getaboden
    @mattssons = create_point_mattssons
    @aabb_getaboden = create_aabb_getaboden
    @aabb_mattssons = create_aabb_mattssons
    @aabb_getaboden_small = create_aabb_getaboden_small
    @aabb_mattssons_small = create_aabb_mattssons_small
  end

  it "has the correct type" do
    expect(@qt).not_to be nil
    expect(@qt).to be_a Quadtree::Quadtree
  end
end
