# frozen_string_literal: true

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

    #
    # Create a new {Quadtree}.
    #
    # @param [AxisAlignedBoundingBox] boundary the boundary for this {Quadtree}.
    # @param [Array<Point>] points any initial {Point}s.
    # @param [Quadtree] north_west northwestern child {Quadtree}
    # @param [Quadtree] north_east northeastern child {Quadtree}
    # @param [Quadtree] south_west southwestern child {Quadtree}
    # @param [Quadtree] south_east southestern child {Quadtree}
    #
    def initialize(boundary, points = [], north_west = nil, north_east = nil, south_west = nil, south_east = nil)
      self.boundary = boundary
      self.points = points
      self.north_west = north_west
      self.north_east = north_east
      self.south_west = south_west
      self.south_east = south_east
    end

    #
    # Create a Hash from this {Quadtree}.
    #
    # @return [Hash] Hash representation.
    #
    def to_h
      {
        'boundary': boundary.to_h,
        'points': points.map(&:to_h),
        'north_west': north_west.nil? ? nil : north_west.to_h,
        'north_east': north_east.nil? ? nil : north_east.to_h,
        'south_west': south_west.nil? ? nil : south_west.to_h,
        'south_east': south_east.nil? ? nil : south_east.to_h
      }
    end

    #
    # Create a Hash from this {Quadtree}.
    #
    # @return [Hash] Hash representation of this {Quadtree}.
    #
    def to_hash
      to_h
    end

    #
    # Create a JSON String representation of this {Quadtree}.
    #
    # @return [String] JSON String of this {Quadtree}.
    #
    def to_json(*_args)
      require 'json'
      to_h.to_json
    end

    #
    # Create a String for this {Quadtree}.
    #
    # @return [String] String representation of this {Quadtree}.
    #
    def to_s
      to_h.to_s
    end

    #
    # Construct a Quadtree from a JSON String.
    #
    # @param [String] json_data input JSON String.
    #
    # @return [Quadtree] the {Quadtree} contained in the JSON String.
    #
    def self.from_json(json_data)
      new(
        AxisAlignedBoundingBox.from_json(json_data['boundary']),
        json_data['points'].map { |point_data| Point.from_json(point_data) },
        json_data['north_west'].nil? ? nil : Quadtree.from_json(json_data['north_west']),
        json_data['north_east'].nil? ? nil : Quadtree.from_json(json_data['north_east']),
        json_data['south_west'].nil? ? nil : Quadtree.from_json(json_data['south_west']),
        json_data['south_east'].nil? ? nil : Quadtree.from_json(json_data['south_east'])
      )
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
    # {Quadtree}.
    #
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
