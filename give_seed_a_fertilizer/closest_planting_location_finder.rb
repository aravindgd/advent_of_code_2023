require_relative "get_destination_from_source"
require_relative "planting_map_builder"

class ClosestPlantingLocationFinder
  def self.run(input)
    new(input).run
  end

  def initialize(input)
    @input = input
  end

  def run
    seed_numbers = get_seeds
    maps = build_maps

    seed_numbers.map do |seed_number|
      soil_number = GetDestinationFromSource.run(source: seed_number, planting_map: maps[:seed_to_soil])
      fertilizer_number = GetDestinationFromSource.run(source: soil_number, planting_map: maps[:soil_to_fertilizer])
      water_number = GetDestinationFromSource.run(source: fertilizer_number, planting_map: maps[:fertilizer_to_water])
      light_number = GetDestinationFromSource.run(source: water_number, planting_map: maps[:water_to_light])
      temperature_number = GetDestinationFromSource.run(source: light_number, planting_map: maps[:light_to_temperature])
      humidity_number = GetDestinationFromSource.run(source: temperature_number, planting_map: maps[:temperature_to_humidity])
      GetDestinationFromSource.run(source: humidity_number, planting_map: maps[:humidity_to_location])
    end.min
  end

  private

  def get_seeds
    split_input[0].gsub("seeds: ", "").split.map(&:to_i)
  end

  def build_maps
    # ignore the seeds and first empty line after
    PlantingMapBuilder.from_input(split_input[2..])
  end

  def split_input
    @split_input ||= @input.split("\n")
  end
end
