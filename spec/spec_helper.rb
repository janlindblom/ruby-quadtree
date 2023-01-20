require "simplecov"
require 'simplecov-cobertura'

SimpleCov.minimum_coverage 80
SimpleCov.minimum_coverage_by_file 45
SimpleCov.start do
  add_filter "/vendor/"
  formatter SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::CoberturaFormatter,
    SimpleCov::Formatter::HTMLFormatter
  ])
end

require "bundler/setup"
require "quadtree"
require 'securerandom'

def create_random_point
  Quadtree::Point.new(-100.0 + SecureRandom.random_number(200.0),
                      -100.0 + SecureRandom.random_number(200.0))
end

def create_random_integer_point
  Quadtree::Point.new((-100.0 + SecureRandom.random_number(200.0)).to_i,
                      (-100.0 + SecureRandom.random_number(200.0)).to_i)
end

def create_random_point_in_aabb(aabb)
  Quadtree::Point.new(
    (aabb.left + SecureRandom.random_number(aabb.right - aabb.left)),
    (aabb.bottom + SecureRandom.random_number(aabb.top - aabb.bottom)))
end

def create_point_getaboden
  Quadtree::Point.new(19.8470050, 60.3747940)
end

def create_point_knutnas
  Quadtree::Point.new(19.8271170, 60.3505570)
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
  Quadtree::AxisAlignedBoundingBox.new(create_point_getaboden, create_point_getaboden.distance_to(create_point_mattssons) / 8)
end

def create_aabb_mattssons_small
  Quadtree::AxisAlignedBoundingBox.new(create_point_mattssons, create_point_mattssons.distance_to(create_point_getaboden) / 8)
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
