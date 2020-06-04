# frozen_string_literal: true

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
    def initialize(x, y, data = nil)
      self.x = get_typed_numeric(x)
      self.y = get_typed_numeric(y)

      self.data = data unless data.nil?
    end

    #
    # Create a Hash for this {Point}.
    #
    # @return [Hash] Hash representation of this {Point}.
    #
    def to_h
      {
        'x': x,
        'y': y,
        'data': process_data(data)
      }
    end

    #
    # Create a Hash for this {Point}.
    #
    # @return [Hash] Hash representation of this {Point}.
    #
    def to_hash
      to_h
    end

    #
    # Create a JSON String representation of this {Point}.
    #
    # @return [String] JSON String of this {Point}.
    #
    def to_json(*_args)
      require 'json'
      to_h.to_json
    end

    #
    # Create a String for this {Point}.
    #
    # @return [String] String representation of this {Point}.
    #
    def to_s
      to_h.to_s
    end

    #
    # Construct a {Quadtree::Point} from a JSON String.
    #
    # @param [String] json_data input JSON String.
    #
    # @return [Quadtree::Point] the {Quadtree::Point} contained in the JSON String.
    #
    def self.from_json(json_data)
      new(json_data['x'], json_data['y'], json_data['data'])
    end

    # This will calculate distance to another {Point}, given that they are
    # both in the same 2D space.
    #
    # @param other [Point] the other {Point}.
    # @return [Float] the distance to the other {Point}.
    def distance_to(other)
      Math.sqrt((other.x - x)**2 + (other.y - y)**2)
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
      lat1 = y * (Math::PI / 180.0)
      lat2 = other.y * (Math::PI / 180.0)
      dlat = (other.y - y) * (Math::PI / 180.0)
      dlon = (other.x - x) * (Math::PI / 180.0)

      # a = sin²(Δφ/2) + cos φ_1 ⋅ cos φ_2 ⋅ sin²(Δλ/2)
      a = calculate_haversine_a(lat1, lat2, dlat, dlon)
      # c = 2 ⋅ atan2( √a, √(1−a) )
      c = 2.0 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
      # d = R ⋅ c
      6371 * 1000.0 * c
    end

    private

    def calculate_haversine_a(lat1, lat2, dlat, dlon)
      Math.sin(dlat / 2.0) * Math.sin(dlat / 2.0) +
        Math.cos(lat1) * Math.cos(lat2) *
        Math.sin(dlon / 2.0) * Math.sin(dlon / 2.0)
    end

    def process_data(data)
      data.nil? || data.is_a?(Array) || data.is_a?(String) || data.is_a?(Numeric) ? data : data.to_h
    end

    def get_typed_numeric(any_input)
      # Try integer first since float will parse integers too
      return get_integer(any_input) unless get_integer(any_input).nil?
      # Try Float next
      return get_float(any_input) unless get_float(any_input).nil?

      raise UnknownTypeError, "Unknown type for parameter: #{any_input.class}"
    end

    def get_integer(any_input)
      return Integer(any_input) if any_input.is_a? String
      return any_input if any_input.is_a? Integer

      nil
    rescue StandardError
      nil
    end

    def get_float(any_input)
      return Float(any_input) if any_input.is_a? String
      return any_input if any_input.is_a? Float

      nil
    rescue StandardError
      nil
    end
  end
end
