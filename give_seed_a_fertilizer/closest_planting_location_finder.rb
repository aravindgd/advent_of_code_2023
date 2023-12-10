require_relative "get_destination_from_source"
require_relative "planting_map_builder"

class ClosestPlantingLocationFinder
  def self.run(seeds:, planting_maps:)
    new(seeds:, planting_maps:).run
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

  private attr_reader :planting_maps, :seeds
end
