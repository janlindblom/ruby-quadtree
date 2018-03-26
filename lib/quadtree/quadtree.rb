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
      self.boundary = boundary
      self.points = []
      self.north_west = nil
      self.north_east = nil
      self.south_west = nil
      self.south_east = nil
    end

    # @param [Point] point
    # @return [Boolean]
    def insert!(point)
      return false unless self.boundary.contains_point?(point)

      if self.points.size < NODE_CAPACITY
        self.points << point
        return true
      end

      subdivide! if self.north_west.nil?
      return true if self.north_west.insert!(point)
      return true if self.north_east.insert!(point)
      return true if self.south_west.insert!(point)
      return true if self.south_east.insert!(point)

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
      return points_in_range unless self.boundary.intersects?(range)

      # Check objects at this quad level
      self.points.each do |point|
        points_in_range << point if range.contains_point?(point)
      end

      # Terminate here, if there are no children
      return points_in_range if self.north_west.nil?

      # Otherwise, add the points from the children
      points_in_range += self.north_west.query_range(range)
      points_in_range += self.north_east.query_range(range)
      points_in_range += self.south_west.query_range(range)
      points_in_range += self.south_east.query_range(range)

      points_in_range
    end

    private

    # @return [Boolean]
    def subdivide!
      left_edge = self.boundary.left
      right_edge = self.boundary.right
      top_edge = self.boundary.top
      bottom_edge = self.boundary.bottom
      quad_half_dimension = self.boundary.half_dimension / 2

      north_west_center = Point.new left_edge + quad_half_dimension, top_edge - quad_half_dimension
      north_east_center = Point.new right_edge - quad_half_dimension, top_edge - quad_half_dimension
      south_east_center = Point.new left_edge + quad_half_dimension, bottom_edge + quad_half_dimension
      south_west_center = Point.new right_edge - quad_half_dimension, bottom_edge + quad_half_dimension

      north_west_boundary = AxisAlignedBoundingBox.new north_west_center, quad_half_dimension
      north_east_boundary = AxisAlignedBoundingBox.new north_east_center, quad_half_dimension
      south_west_boundary = AxisAlignedBoundingBox.new south_west_center, quad_half_dimension
      south_east_boundary = AxisAlignedBoundingBox.new south_east_center, quad_half_dimension

      self.north_west = Quadtree.new north_west_boundary
      self.north_east = Quadtree.new north_east_boundary
      self.south_west = Quadtree.new south_west_boundary
      self.south_east = Quadtree.new south_east_boundary

      true
    rescue => error
      puts "Something went wrong: #{error}"
      false
    end
  end
end
