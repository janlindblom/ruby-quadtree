module Quadtree
    # Simple coordinate object to represent points in some space.
    class Point

      # The X coordinate of this instance.
      # @return [Float, Integer] X coordinate.
      attr_accessor :x

      # The Y coordinate of this instance.
      # @return [Float, Integer] Y coordinate.
      attr_accessor :y

      # Optional payload attached to this instance.
      # @return [Object] payload attached to this instance.
      attr_accessor :data

      # @param x [Float, Integer] X coordinate.
      # @param y [Float, Integer] Y coordinate.
      # @param data [Object] payload payload attached to this instance
      #   (optional).
      # @raise [UnknownTypeError] if one or more input parameters (+x+ and +y+)
      #   has the wrong type.
      def initialize(x, y, data=nil)

        self.x = get_typed_numeric(x)
        self.y = get_typed_numeric(y)

        self.data = data unless data.nil?
      end

      def to_h
        {
          x: x,
          y: y,
          data: data.nil? || data.is_a?(Array) || data.is_a?(String) ? data : data.to_h
        }
      end

      def to_hash
        to_h
      end

      def to_json(*a)
        require 'json'
        to_h.to_json(*a)
      end

      def to_s
        to_h.to_s
      end

      def self.from_json(json_data)
        new(json_data['x'], json_data['y'], json_data['data'])
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

      private

      def get_typed_numeric(any_input)
        typed_output = nil
        # Try integer first since float will parse integers too
        return get_integer(any_input) unless get_integer(any_input).nil?
        # Try Float next
        return get_float(any_input) unless get_float(any_input).nil?

        raise UnknownTypeError.new "Unknown type for parameter: #{any_input.class}"

        #typed_output
      end

      def get_integer(any_input)
        return Integer(any_input) if any_input.is_a? String
        return any_input if any_input.is_a? Integer

        nil
      rescue
        nil
      end

      def get_float(any_input)
        return Float(any_input) if any_input.is_a? String
        return any_input if any_input.is_a? Float

        nil
      rescue
        nil
      end
    end
end
