module Quadtree
  class Quadtree
    NODE_CAPACITY = 4
    attr_accessor :boundary
    attr_accessor :points

    attr_accessor :north_west
    attr_accessor :north_east
    attr_accessor :south_west
    attr_accessor :south_east

    def initialize(boundary)
      @boundary = boundary
      @points = []
      @north_west = nil
      @north_east = nil
      @south_west = nil
      @south_east = nil
    end


    def insert(point)
      return false unless @boundary.contains_point? point

      if points.size < NODE_CAPACITY
        points << point
        return true
      end

      subdivide! if @north_west.nil?
      return true if @north_west.insert(point)
      return true if @north_east.insert(point)
      return true if @south_west.insert(point)
      return true if @south_east.insert(point)

      false
    end

    def subdivide!
      left_edge = @boundary.left
      right_edge = @boundary.right
      top_edge = @boundary.top
      bottom_edge = @boundary.bottom
      quad_half_dimension = @boundary.half_dimension / 2

      north_west_center = Quadtree::Point.new left_edge + quad_half_dimension, top_edge - quad_half_dimension
      north_east_center = Quadtree::Point.new right_edge - quad_half_dimension, top_edge - quad_half_dimension
      south_east_center = Quadtree::Point.new left_edge + quad_half_dimension, bottom_edge + quad_half_dimension
      south_west_center = Quadtree::Point.new right_edge - quad_half_dimension, bottom_edge + quad_half_dimension

      north_west_boundary = Quadtree::AxisAlignedBoundingBox.new north_west_center, quad_half_dimension
      north_east_boundary = Quadtree::AxisAlignedBoundingBox.new north_east_center, quad_half_dimension
      south_west_boundary = Quadtree::AxisAlignedBoundingBox.new south_west_center, quad_half_dimension
      south_east_boundary = Quadtree::AxisAlignedBoundingBox.new south_east_center, quad_half_dimension

      @north_west = Quadtree::Quadtree.new north_west_boundary
      @north_east = Quadtree::Quadtree.new north_east_boundary
      @south_west = Quadtree::Quadtree.new south_west_boundary
      @south_east = Quadtree::Quadtree.new south_east_boundary

      true
    end

    def query_range(range)

    end
  end
end
