module Quadtree
  # A Quadtree.
  class Quadtree
    # Arbitrary constant to indicate how many elements can be stored in this
    # quad tree node.
    # @return [Integer] number of {Point}s this {Quadtree} can hold.
    NODE_CAPACITY = 4

    # Axis-aligned bounding box stored as a center with half-dimensions to
    # represent the boundaries of this quad tree.
    # @return [AxisAlignedBoundingBox]
    attr_accessor :boundary

    # Points in this quad tree node.
    # @return [Array<Point>]
    attr_accessor :points

    # Children

    # North west corner of this quad.
    # @return [Quadtree]
    attr_accessor :north_west

    # North east corner of this quad.
    # @return [Quadtree]
    attr_accessor :north_east

    # South west corner of this quad.
    # @return [Quadtree]
    attr_accessor :south_west

    # South east corner of this quad.
    # @return [Quadtree]
    attr_accessor :south_east

    # @param boundary [AxisAlignedBoundingBox] the boundary for this {Quadtree}.
    def initialize(boundary)
      self.boundary = boundary
      self.points = []
      self.north_west = nil
      self.north_east = nil
      self.south_west = nil
      self.south_east = nil
    end

    # Insert a {Point} in this {Quadtree}.
    #
    # @param point [Point] the point to insert.
    # @return [Boolean] +true+ on success, +false+ otherwise.
    def insert!(point)
      return false unless boundary.contains_point?(point)

      if points.size < NODE_CAPACITY
        points << point
        return true
      end

      subdivide! if north_west.nil?
      return true if north_west.insert!(point)
      return true if north_east.insert!(point)
      return true if south_west.insert!(point)
      return true if south_east.insert!(point)

      false
    end

    # Return the size of this instance, the number of {Point}s stored in this
    #   {Quadtree}.
    # @return [Integer] the size of this instance.
    def size
      count = 0
      count += points.size
      unless north_west.nil?
        count += north_west.size
        count += north_east.size
        count += south_west.size
        count += south_east.size
      end
      count
    end

    # Finds all points contained within a range.
    #
    # @param range [AxisAlignedBoundingBox] the range to search within.
    # @return [Array<Point>] all {Point}s in given range.
    def query_range(range)
      # Prepare an array of results
      points_in_range = []

      # Automatically abort if the range does not intersect this quad
      return points_in_range unless boundary.intersects?(range)

      # Check objects at this quad level
      points.each do |point|
        points_in_range << point if range.contains_point?(point)
      end

      # Terminate here, if there are no children
      return points_in_range if north_west.nil?

      # Otherwise, add the points from the children
      points_in_range += north_west.query_range(range)
      points_in_range += north_east.query_range(range)
      points_in_range += south_west.query_range(range)
      points_in_range += south_east.query_range(range)

      points_in_range
    end

    private

    # @return [Boolean] +true+ on success, +false+ otherwise.
    def subdivide!
      left_edge = boundary.left
      right_edge = boundary.right
      top_edge = boundary.top
      bottom_edge = boundary.bottom
      quad_half_dimension = boundary.half_dimension / 2

      north_west_center = Point.new(left_edge + quad_half_dimension,
                                    top_edge - quad_half_dimension)
      north_east_center = Point.new(right_edge - quad_half_dimension,
                                    top_edge - quad_half_dimension)
      south_east_center = Point.new(left_edge + quad_half_dimension,
                                    bottom_edge + quad_half_dimension)
      south_west_center = Point.new(right_edge - quad_half_dimension,
                                    bottom_edge + quad_half_dimension)

      north_west_boundary = AxisAlignedBoundingBox.new(north_west_center,
                                                       quad_half_dimension)
      north_east_boundary = AxisAlignedBoundingBox.new(north_east_center,
                                                       quad_half_dimension)
      south_west_boundary = AxisAlignedBoundingBox.new(south_west_center,
                                                       quad_half_dimension)
      south_east_boundary = AxisAlignedBoundingBox.new(south_east_center,
                                                       quad_half_dimension)

      self.north_west = Quadtree.new north_west_boundary
      self.north_east = Quadtree.new north_east_boundary
      self.south_west = Quadtree.new south_west_boundary
      self.south_east = Quadtree.new south_east_boundary

      true
    rescue StandardError
      false
    end
  end
end
