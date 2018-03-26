module Quadtree
  # A Quadtree
  class Quadtree

    # Arbitrary constant to indicate how many elements can be stored in this
    # quad tree node.
    # @return [Integer]
    NODE_CAPACITY = 4

    # Axis-aligned bounding box stored as a center with half-dimensions to
    # represent the boundaries of this quad tree.
    # @return [AxisAlignedBoundingBox]
    attr_accessor :boundary

    # Points in this quad tree node.
    # @return [Array<Point>]
    attr_accessor :points

    # Children

    # @return [Quadtree]
    attr_accessor :north_west
    # @return [Quadtree]
    attr_accessor :north_east
    # @return [Quadtree]
    attr_accessor :south_west
    # @return [Quadtree]
    attr_accessor :south_east

    def initialize(boundary)
      @boundary = boundary
      @points = []
      @north_west = nil
      @north_east = nil
      @south_west = nil
      @south_east = nil
    end

    # @param [Point] point
    # @return [Boolean]
    def insert!(point)
      return false unless @boundary.contains_point?(point)

      if points.size < NODE_CAPACITY
        @points << point
        return true
      end

      subdivide! if @north_west.nil?
      return true if @north_west.insert(point)
      return true if @north_east.insert(point)
      return true if @south_west.insert(point)
      return true if @south_east.insert(point)

      false
    end

    # Finds all points contained within a range.
    #
    # @param [AxisAlignedBoundingBox] range the range to search within.
    # @return [Array<Point>]
    def query_range(range)
      # Prepare an array of results
      points_in_range = []

      # Automatically abort if the range does not intersect this quad
      return points_in_range unless @boundary.intersects?(range)

      # Check objects at this quad level
      @points.each do |point|
        points_in_range << point if range.contains_point?(point)
      end

      # Terminate here, if there are no children
      return points_in_range if @north_west.nil?

      # Otherwise, add the points from the children
      points_in_range += @north_west.query_range(range)
      points_in_range += @north_east.query_range(range)
      points_in_range += @south_west.query_range(range)
      points_in_range += @south_east.query_range(range)

      points_in_range
    end

    private

    # @return [Boolean]
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
    rescue
      false
    end
  end
end
