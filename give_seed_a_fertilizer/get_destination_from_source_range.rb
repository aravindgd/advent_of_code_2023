# frozen_string_literal: true
require_relative "../range_utils"

class GetDestinationFromSourceRange
  using RangeUtils

  def self.run(seed_range:, planting_map:)
    source_planting_map_line = planting_map.map_lines.select do |map_line|
    end
  end

  # matching_seed_range = 40..60
  # map_line_source_range = 30..70
  # map_line_destination_range = 20..60
  # 20..40
  def get_matching_destination_range(matching_seed_range, map_line)
    position_to_start_match = matching_seed_range.begin - map_line.source_range_start

    Range.build_from_size(map_line.destination_range_start + position_to_start_match, matching_seed_range.size)
  end

  # should always return some form of the seed range value, either matching destination range
  # or itself
  def get_possible_destination_ranges(seed_range:, map_line:)
    map_line_source_range = map_line.source_range

    # no overlap at all
    # seed_range = 30..70
    # map_line_source_range = 71..100
    return [seed_range] if !map_line_source_range.overlaps?(seed_range)

    # seed range is a subset of the map line source range
    # seed_range = 40..60
    # map_line_source_range = 30..70
    return [get_matching_destination_range(seed_range, map_line)] if map_line_source_range.cover?(seed_range)

    # map line source range is a subset of the seed range
    # seed_range = 1..100
    # map_line_source_range = 30..70
    if seed_range.cover?(map_line_source_range)
      [
        # 1..29
        seed_range.begin..(map_line.source_range.begin - 1),
        # 30..70
        get_matching_destination_range(map_line_source_range, map_line),
        # 71..100
        (map_line.source_range.end + 1)..seed_range.end
      ]
    # seed_range = 30..70
    # map_line_source_range = 50..100
    elsif map_line_source_range.begin > seed_range.begin && map_line_source_range.end > seed_range.end
      [
        # 30..49
        seed_range.begin..(map_line.source_range.begin - 1),
        # 50..70
        get_matching_destination_range(map_line_source_range.begin..seed_range.end, map_line)
      ]
    # seed_range = 50..100
    # map_line_source_range = 30..70
    elsif map_line_source_range.begin < seed_range.begin && map_line_source_range.end < seed_range.end
      [
        # 50..70
        get_matching_destination_range(seed_range.begin..map_line.source_range.end, map_line),
        # 71..100
        (map_line_source_range.end + 1)..seed_range.end
      ]
    end
  end
end
