require 'securerandom'

RSpec.describe Quadtree::Quadtree do
  before :all do
    @center = create_random_point
    @half_dim = SecureRandom.random_number 100.0
    @qt = Quadtree::Quadtree.new(create_random_aabb)
    @getaboden = create_point_getaboden
    @mattssons = create_point_mattssons
    @knutnas = create_point_knutnas
    @aabb_getaboden = create_aabb_getaboden
    @aabb_mattssons = create_aabb_mattssons
    @aabb_getaboden_small = create_aabb_getaboden_small
    @aabb_mattssons_small = create_aabb_mattssons_small
    @qt_geta_small = Quadtree::Quadtree.new(@aabb_getaboden_small)
    @qt_geta = Quadtree::Quadtree.new(@aabb_getaboden)
    @qt_finstrom_small = Quadtree::Quadtree.new(@aabb_mattssons_small)
    @qt_finstrom = Quadtree::Quadtree.new(@aabb_mattssons)
  end

  it "has the correct type" do
    expect(@qt).not_to be nil
    expect(@qt).to be_a Quadtree::Quadtree
  end

  it "can hold points if they belong within the boundary" do
    expect(@qt_geta.insert!(@knutnas)).to be true
    expect(@qt_geta_small.insert!(@knutnas)).to be true
  end

  it "can find all points within a range" do
    @qt_geta.insert! @knutnas
    res = @qt_geta.query_range(@aabb_getaboden)
    expect(res).not_to be nil
    expect(res).to be_a Array
    expect(res.size).to be > 1
    res.each do |p|
      expect(p).to be_a Quadtree::Point
    end
  end

  it "will subdivide itself if added points does not fit" do
    aabb = create_random_aabb
    tree = Quadtree::Quadtree.new(aabb)
    points = 160
    (1..points).each do |p|
      expect(tree.insert!(create_random_point_in_aabb(aabb))).to eq true
    end
    expect(tree.north_west).not_to be_nil
    expect(tree.north_east).not_to be_nil
    expect(tree.south_west).not_to be_nil
    expect(tree.south_east).not_to be_nil
    expect(tree.size).to eq points
  end
end
