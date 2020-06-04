module Quadtree
  # Axis-aligned bounding box with half dimension and center.
  class AxisAlignedBoundingBox

    # Center {Point} of this instance.
    #
    # @return [Point] the {Point} marking the center of this instance.
    attr_accessor :center

    # Half dimension of this instance (distance from the center {Point} to the
    # edge).
    #
    # @return [Float] distance from the center {Point} to the edge.
    attr_accessor :half_dimension

    # @param center [Point]
    # @param half_dimension [Float]
    def initialize(center, half_dimension)
      @center = center
      @half_dimension = half_dimension.to_f
    end

    def to_h
      {
        center: center.to_h,
        half_dimension: half_dimension
      }
    end

    def to_hash
      to_h
    end

    def to_json(*a)
      require 'json'
      to_h.to_json(*a)
    end

    def self.from_json(json_data)
      new(Point.from_json(json_data['center']), json_data['half_dimension'])
    end

    # Check if this instance contains a given {Point}.
    #
    # @param point [Point] the {Point} to check for.
    # @return [Boolean] +true+ if given {Point} is contained, +false+
    #   otherwise.
    def contains_point?(point)
      if point.x >= self.center.x - self.half_dimension &&
          point.x <= self.center.x + self.half_dimension
        if point.y >= self.center.y - self.half_dimension &&
          point.y <= self.center.y + self.half_dimension
          return true
        end
      end
      false
    end

    # Check if this instance intersects with another instance.
    #
    # @param other [AxisAlignedBoundingBox] the other instance to check for.
    # @return [Boolean] +true+ if these intersects, +false+ otherwise.
    def intersects?(other)
      other_lt_corner = Point.new(other.left, other.top)
      other_rt_corner = Point.new(other.right, other.top)
      other_lb_corner = Point.new(other.left, other.bottom)
      other_rb_corner = Point.new(other.right, other.bottom)

      [
        other_lt_corner,
        other_rt_corner,
        other_lb_corner,
        other_rb_corner
      ].each do |corner|
        return true if self.contains_point?(corner)
      end
      false
    end

    # Get the X coordinate of the left edge of this instance.
    #
    # @return [Float] the X coordinate of the left edge of this instance.
    def left
      @center.x - @half_dimension
    end

    # Get the X coordinate of the right edge of this instance.
    #
    # @return [Float] the X coordinate of the right edge of this instance.
    def right
      @center.x + @half_dimension
    end

    # Get the Y coordinate of the top edge of this instance.
    #
    # @return [Float] the Y coordinate of the top edge of this instance.
    def top
      @center.y + @half_dimension
    end

    # Get the Y coordinate of the bottom edge of this instance.
    #
    # @return [Float] the Y coordinate of the bottom edge of this instance.
    def bottom
      @center.y - @half_dimension
    end

    # Get the width of this instance.
    #
    # @return [Float]
    def width
      span
    end

    # Get the height of this instance.
    #
    # @return [Float]
    def height
      span
    end

    private

    def span
      @half_dimension * 2
    end
  end
end
