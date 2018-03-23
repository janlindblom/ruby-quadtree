require "bundler/setup"
require "quadtree"
require 'securerandom'

def create_random_point
  Quadtree::Point.new(-100.0 + SecureRandom.random_number(200.0),
                      -100.0 + SecureRandom.random_number(200.0))
end

def create_point_getaboden
  Quadtree::Point.new(19.8470050, 60.3747940)
end

def create_point_mattssons
  Quadtree::Point.new(19.9895930, 60.2302620)
end

def create_aabb_getaboden
  Quadtree::AxisAlignedBoundingBox.new(create_point_getaboden, create_point_getaboden.distance_to(create_point_mattssons) / 2)
end

def create_aabb_mattssons
  Quadtree::AxisAlignedBoundingBox.new(create_point_mattssons, create_point_mattssons.distance_to(create_point_getaboden) / 2)
end

def create_aabb_getaboden_small
  Quadtree::AxisAlignedBoundingBox.new(create_point_getaboden, create_point_getaboden.distance_to(create_point_mattssons) / 4)
end

def create_aabb_mattssons_small
  Quadtree::AxisAlignedBoundingBox.new(create_point_mattssons, create_point_mattssons.distance_to(create_point_getaboden) / 4)
end

def create_random_aabb
  Quadtree::AxisAlignedBoundingBox.new(create_random_point, SecureRandom.random_number(100.0))
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
