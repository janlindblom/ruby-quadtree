module Quadtree
  # Axis-aligned bounding box with half dimension and center.
  class AxisAlignedBoundingBox

    # @return [Point]
    attr_accessor :center
    # @return [Float]
    attr_accessor :half_dimension

    # @param [Point] center
    # @param [Float] half_dimension
    def initialize(center, half_dimension)
      @center = center
      @half_dimension = half_dimension.to_f
    end

    # @param [Point] point
    # @return [Boolean]
    def contains_point?(point)
      if point.x >= self.center.x - self.half_dimension and point.x <= self.center.x + self.half_dimension
        if point.y >= self.center.y - self.half_dimension and point.y <= self.center.y + self.half_dimension
          return true
        end
      end
      false
    end

    # @param [AxisAlignedBoundingBox] other
    # @return [Boolean]
    def intersects?(other)
      other_lt_corner = Point.new(other.left, other.top)
      other_rt_corner = Point.new(other.right, other.top)
      other_lb_corner = Point.new(other.left, other.bottom)
      other_rb_corner = Point.new(other.right, other.bottom)

      [other_lt_corner, other_rt_corner, other_lb_corner, other_rb_corner].each do |corner|
        return true if self.contains_point?(corner)
      end
      false
    end

    # @return [Float]
    def left
      @center.x - @half_dimension
    end

    # @return [Float]
    def right
      @center.x + @half_dimension
    end

    # Get the Y coordinate of the top edge of this AABB.
    #
    # @return [Float] the Y coordinate of the top edge of this AABB.
    def top
      @center.y + @half_dimension
    end

    # Get the Y coordinate of the bottom edge of this AABB.
    #
    # @return [Float] the Y coordinate of the bottom edge of this AABB.
    def bottom
      @center.y - @half_dimension
    end

    # @return [Float]
    def width
      span
    end

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
