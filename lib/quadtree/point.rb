module Quadtree
    # Simple coordinate object to represent points and vectors.
    class Point
      # @return [Float] X coordinate
      attr_accessor :x
      # @return [Float] Y coordinate
      attr_accessor :y

      # Create a new {Point}.
      #
      # @param [Float] x X coordinate
      # @param [Float] y Y coordinate
      def initialize(x, y)
        @x = x
        @y = y
      end

      def distance_to(other)
        Math.sqrt((other.x - self.x) ** 2 + (other.y - self.y) ** 2)
      end

      # This will calculate distance to another point using the Haversine
      # formula. This means that it will treat #x as longitude and #y as
      # latitude!
      #
      # a = sin²(Δφ/2) + cos φ_1 ⋅ cos φ_2 ⋅ sin²(Δλ/2)
      # c = 2 ⋅ atan2( √a, √(1−a) )
      # d = R ⋅ c
      #
      # where φ is latitude, λ is longitude, R is earth’s radius (mean
      # radius = 6 371 km);
      # note that angles need to be in radians to pass to trig functions!
      #
      # @param [Point] other
      # @return [Float]
      def haversine_distance_to(other)
        r = 6371 * 1000.0
        lat1 = self.y * (Math::PI / 180)
        lat2 = other.y * (Math::PI / 180)
        dlat = (other.y - self.y) * (Math::PI / 180)
        dlon = (other.x - self.x) * (Math::PI / 180)

        a = Math.sin(dlat / 2) * Math.sin(dlat / 2) +
            Math.cos(lat1) * Math.cos(lat2) *
            Math.sin(dlon / 2) * Math.sin(dlon / 2)
        c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

        r * c
      end
    end
end
