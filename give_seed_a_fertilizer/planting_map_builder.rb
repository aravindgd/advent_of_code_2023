require_relative "planting_maps"
require_relative "../array_utils"

class PlantingMapBuilder
  include PlantingMaps

  using ArrayUtils

  def self.from_input(map_inputs)
    new(map_inputs).run
  end

  def initialize(map_inputs)
    @map_inputs = map_inputs
  end

  def run
    {
      seed_to_soil: SeedToSoilMap.build_from_map_lines_input(split_map_inputs[0]),
      soil_to_fertilizer: SoilToFertilizerMap.build_from_map_lines_input(split_map_inputs[1]),
      fertilizer_to_water: FertilizerToWaterMap.build_from_map_lines_input(split_map_inputs[2]),
      water_to_light: WaterToLightMap.build_from_map_lines_input(split_map_inputs[3]),
      light_to_temperature: LightToTemperatureMap.build_from_map_lines_input(split_map_inputs[4]),
      temperature_to_humidity: TemperatureToHumidityMap.build_from_map_lines_input(split_map_inputs[5]),
      humidity_to_location: HumidityToLocationMap.build_from_map_lines_input(split_map_inputs[6])
    }
  end

  private

  def split_map_inputs
    @split_map_inputs ||= @map_inputs.split_at_value("").map do |map_input|
      # remove the map category name
      map_input.drop(1)
    end
  end
end
