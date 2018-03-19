module Quadtree
  class AxisAlignedBoundingBox
    attr_accessor :center
    attr_accessor :half_dimension

    def initialize(center, half_dimension)
      @center = center
      @half_dimension = half_dimension
    end

    def contains_point?(point)
      if point.x >= self.center.x - self.half_dimension and point.x <= self.center.x + self.half_dimension
        if point.y >= self.center.y - self.half_dimension and point.y <= self.center.y + self.half_dimension
          return true
        end
      end
      false
    end

    def intersects?(other_aabb)
      false
    end

    def left
      @center.x - @half_dimension
    end

    def right
      @center.x + @half_dimension
    end

    def top
      @center.y + @half_dimension
    end

    def bottom
      @center.y - @half_dimension
    end

    def width
      span
    end

    def height
      span
    end

    private

    def span
      @half_dimension * 2
    end
  end
end
