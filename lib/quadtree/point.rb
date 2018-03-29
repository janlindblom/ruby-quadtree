module Quadtree
    # Simple coordinate object to represent points in some space.
    class Point

      # The X coordinate of this instance.
      # @return [Float] X coordinate.
      attr_accessor :x

      # The Y coordinate of this instance.
      # @return [Float] Y coordinate.
      attr_accessor :y

      # Optional payload attached to this instance.
      # @return [Object] payload attached to this instance.
      attr_accessor :data

      # @param x [Float, Numeric] X coordinate.
      # @param y [Float, Numeric] Y coordinate.
      # @param data [Object] payload payload attached to this instance
      #   (optional).
      def initialize(x, y, data=nil)
        @x = x.to_f
        @y = y.to_f
        @data = data unless data.nil?
      end

      # This will calculate distance to another {Point}, given that they are
      # both in the same 2D space.
      #
      # @param other [Point] the other {Point}.
      # @return [Float] the distance to the other {Point}.
      def distance_to(other)
        Math.sqrt((other.x - self.x) ** 2 + (other.y - self.y) ** 2)
      end

      # This will calculate distance to another {Point} using the Haversine
      # formula. This means that it will treat {#x} as longitude and {#y} as
      # latitude!
      #
      # a = sin²(Δφ/2) + cos φ_1 ⋅ cos φ_2 ⋅ sin²(Δλ/2)
      #
      # c = 2 ⋅ atan2( √a, √(1−a) )
      #
      # d = R ⋅ c
      #
      # where φ is latitude, λ is longitude, R is earth’s radius (mean
      # radius = 6 371 km);
      # note that angles need to be in radians to pass to trig functions!
      #
      # @param other [Point] the other {Point}.
      # @return [Float] the distance, in meters, to the other {Point}.
      def haversine_distance_to(other)
        # earth's radius
        r = 6371 * 1000.0
        # coverting degrees to radians
        lat1 = self.y * (Math::PI / 180.0)
        lat2 = other.y * (Math::PI / 180.0)
        dlat = (other.y - self.y) * (Math::PI / 180.0)
        dlon = (other.x - self.x) * (Math::PI / 180.0)

        # a = sin²(Δφ/2) + cos φ_1 ⋅ cos φ_2 ⋅ sin²(Δλ/2)
        a = Math.sin(dlat / 2.0) * Math.sin(dlat / 2.0) +
            Math.cos(lat1) * Math.cos(lat2) *
            Math.sin(dlon / 2.0) * Math.sin(dlon / 2.0)
        # c = 2 ⋅ atan2( √a, √(1−a) )
        c = 2.0 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
        # d = R ⋅ c
        return r * c
      end
    end
end
