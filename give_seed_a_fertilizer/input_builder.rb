# frozen_string_literal: true

require_relative "../array_utils"

class InputBuilder
  using ArrayUtils

  class << self
    def seeds_input(input)
      split_input = input.split("\n")

      split_input[0].gsub("seeds: ", "").split.map(&:to_i)
    end

    def planting_map_input(input)
      split_input = input.split("\n")

      split_input[2..].split_at_value("").map do |map_input|
        # remove the map category name
        map_input = map_input.drop(1)

        map_input.map do |line|
          destination_range_start, source_range_start, range = line.split

          {destination_range_start:, source_range_start:, range:}
        end
      end
    end
  end
end
