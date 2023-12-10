require "rspec"
require_relative "planting_map_builder"

describe PlantingMapBuilder do
  subject { described_class.new(input).run }

  let(:input) do
    [
      "seed-to-soil map:",
      "50 98 2",
      "52 50 48",
      "",
      "soil-to-fertilizer map:",
      "0 15 37",
      "37 52 2",
      "39 0 15",
      "",
      "fertilizer-to-water map:",
      "49 53 8",
      "0 11 42",
      "42 0 7",
      "57 7 4",
      "",
      "water-to-light map:",
      "88 18 7",
      "18 25 70",
      "",
      "light-to-temperature map:",
      "45 77 23",
      "81 45 19",
      "68 64 13",
      "",
      "temperature-to-humidity map:",
      "0 69 1",
      "1 0 69",
      "",
      "humidity-to-location map:",
      "60 56 37",
      "56 93 4"
    ]
  end

  it "returns a collections of all the map objects" do
    maps = subject

    seed_to_soil_map = maps[0]
    expect(seed_to_soil_map.map_lines.count).to eq 2

    expect(seed_to_soil_map.map_lines[0].source_range).to eq 98..99
    expect(seed_to_soil_map.map_lines[0].destination_range).to eq 50..51

    expect(seed_to_soil_map.map_lines[1].source_range).to eq 50..97
    expect(seed_to_soil_map.map_lines[1].destination_range).to eq 52..99

    soil_to_fertilizer_map = maps[1]

    expect(soil_to_fertilizer_map.map_lines.count).to eq 3

    expect(soil_to_fertilizer_map.map_lines[0].source_range).to eq 15..51
    expect(soil_to_fertilizer_map.map_lines[0].destination_range).to eq 0..36

    expect(soil_to_fertilizer_map.map_lines[1].source_range).to eq 52..53
    expect(soil_to_fertilizer_map.map_lines[1].destination_range).to eq 37..38

    expect(soil_to_fertilizer_map.map_lines[2].source_range).to eq 0..14
    expect(soil_to_fertilizer_map.map_lines[2].destination_range).to eq 39..53
  end
end
