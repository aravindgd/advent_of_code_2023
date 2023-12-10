# frozen_string_literal: true

module PlantingMaps
  class BaseMap
    def self.build_from_map_lines_input(map_lines_input)
      map_lines = map_lines_input.map do |line|
        destination_range_start, source_range_start, range = line.split

        MapLine.new(destination_range_start:, source_range_start:, range:)
      end

      new(map_lines: map_lines)
    end

    attr_reader :map_lines

    def initialize(map_lines:)
      @map_lines = map_lines
    end

    def source_range
      return if map_lines.nil? && map_lines.empty?

      @source_range ||= begin
        source_ranges = map_lines.map(&:source_range).map(&:minmax).flatten
        source_ranges.min..source_ranges.max
      end
    end

    def destination_range
      return if map_lines.nil? && map_lines.empty?

      @destination_range ||= begin
        destination_ranges = map_lines.map(&:destination_range).map(&:minmax).flatten
        destination_ranges.min..destination_ranges.max
      end
    end
  end

  class MapLine
    attr_reader :destination_range_start, :source_range_start, :range

    def initialize(source_range_start:, destination_range_start:, range:)
      @destination_range_start = destination_range_start.to_i
      @source_range_start = source_range_start.to_i
      @range = range.to_i
    end

    def destination_range
      @destination_range ||= destination_range_start..(destination_range_start + range - 1)
    end

    def source_range
      @source_range ||= source_range_start..(source_range_start + range - 1)
    end
  end

  class SeedToSoilMap < BaseMap
  end

  class SoilToFertilizerMap < BaseMap
  end

  class FertilizerToWaterMap < BaseMap
  end

  class WaterToLightMap < BaseMap
  end

  class LightToTemperatureMap < BaseMap
  end

  class TemperatureToHumidityMap < BaseMap
  end

  class HumidityToLocationMap < BaseMap
  end
end
