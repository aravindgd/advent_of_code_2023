# frozen_string_literal: true

class GetDestinationFromSource
  def self.run(source:, planting_map:)
    source_planting_map_line = planting_map.map_lines.find do |map_line|
      map_line.source_range.include?(source)
    end

    return source if source_planting_map_line.nil?

    source_planting_map_line.destination_range_start + (source - source_planting_map_line.source_range_start)
  end
end
