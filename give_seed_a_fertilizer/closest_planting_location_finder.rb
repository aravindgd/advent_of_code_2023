require_relative "get_destination_from_source"
require_relative "get_destination_from_source_range"
require_relative "planting_map_builder"

class ClosestPlantingLocationFinder
  def self.run(seeds:, planting_maps:, seed_range: false)
    if seed_range
      new(seeds:, planting_maps:).for_seed_range
    else
      new(seeds:, planting_maps:).run
    end
  end

  def initialize(seeds:, planting_maps:)
    @planting_maps = planting_maps
    @seeds = seeds
  end

  def run
    seeds.map do |seed_number|
      soil_number = GetDestinationFromSource.run(source: seed_number, planting_map: planting_maps[:seed_to_soil])
      fertilizer_number = GetDestinationFromSource.run(source: soil_number, planting_map: planting_maps[:soil_to_fertilizer])
      water_number = GetDestinationFromSource.run(source: fertilizer_number, planting_map: planting_maps[:fertilizer_to_water])
      light_number = GetDestinationFromSource.run(source: water_number, planting_map: planting_maps[:water_to_light])
      temperature_number = GetDestinationFromSource.run(source: light_number, planting_map: planting_maps[:light_to_temperature])
      humidity_number = GetDestinationFromSource.run(source: temperature_number, planting_map: planting_maps[:temperature_to_humidity])
      GetDestinationFromSource.run(source: humidity_number, planting_map: planting_maps[:humidity_to_location])
    end.min
  end

  def for_seed_range
    seeds.map do |seed_range|
      soil_ranges = GetDestinationFromSourceRange.run(source_range: seed_range, planting_map: planting_maps[:seed_to_soil])
      fertilizer_ranges = soil_ranges.map do |soil_range|
        GetDestinationFromSourceRange.run(source_range: soil_range, planting_map: planting_maps[:soil_to_fertilizer])
      end
      water_ranges = fertilizer_ranges.map do |fertilizer_range|
        GetDestinationFromSourceRange.run(source_range: fertilizer_range, planting_map: planting_maps[:fertilizer_to_water])
      end
      light_ranges = water_ranges.map do |water_range|
        GetDestinationFromSourceRange.run(source_range: water_range, planting_map: planting_maps[:water_to_light])
      end
      temperature_ranges = light_ranges.map do |light_range|
        GetDestinationFromSourceRange.run(source_range: light_range, planting_map: planting_maps[:light_to_temperature])
      end
      humidity_ranges = temperature_ranges.map do |temperature_range|
        GetDestinationFromSourceRange.run(source_range: temperature_range, planting_map: planting_maps[:temperature_to_humidity])
      end
      result = humidity_ranges.map do |humidity_range|
        GetDestinationFromSourceRange.run(source_range: humidity_range, planting_map: planting_maps[:humidity_to_location])
      end
      binding.irb
    end
  end

  private attr_reader :planting_maps, :seeds
end
