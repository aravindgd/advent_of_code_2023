# frozen_string_literal: true

require_relative "input_builder"
require_relative "planting_maps"

class PlantingMapBuilder
  include PlantingMaps

  def self.from_input(input)
    new(input).run
  end

  def initialize(input)
    @input = input
  end

  def run
    {
      seed_to_soil: SeedToSoilMap.build_from_map_lines_input(map_inputs[0]),
      soil_to_fertilizer: SoilToFertilizerMap.build_from_map_lines_input(map_inputs[1]),
      fertilizer_to_water: FertilizerToWaterMap.build_from_map_lines_input(map_inputs[2]),
      water_to_light: WaterToLightMap.build_from_map_lines_input(map_inputs[3]),
      light_to_temperature: LightToTemperatureMap.build_from_map_lines_input(map_inputs[4]),
      temperature_to_humidity: TemperatureToHumidityMap.build_from_map_lines_input(map_inputs[5]),
      humidity_to_location: HumidityToLocationMap.build_from_map_lines_input(map_inputs[6])
    }
  end

  private

  def map_inputs
    # ignore the seeds and first empty line after
    @map_inputs = InputBuilder.planting_map_input(@input)
  end
end
