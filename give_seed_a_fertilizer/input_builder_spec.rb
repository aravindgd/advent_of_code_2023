require "rspec"
require_relative "input_builder"

describe InputBuilder do
  let(:input) do
    <<~EOS
      seeds: 79 14 55 13

      seed-to-soil map:
      50 98 2
      52 50 48

      soil-to-fertilizer map:
      0 15 37
      37 52 2
      39 0 15

      fertilizer-to-water map:
      49 53 8
      0 11 42
      42 0 7
      57 7 4

      water-to-light map:
      88 18 7
      18 25 70

      light-to-temperature map:
      45 77 23
      81 45 19
      68 64 13

      temperature-to-humidity map:
      0 69 1
      1 0 69

      humidity-to-location map:
      60 56 37
      56 93 4
    EOS
  end

  describe ".seeds_input" do
    subject { described_class.seeds_input(input) }

    it "returns the seeds input" do
      expect(subject).to eq [79, 14, 55, 13]
    end
  end

  describe ".map_input" do
    subject { described_class.planting_map_input(input) }

    it "returns the map input" do
      expect(subject).to eq [
        [
          {destination_range_start: "50", source_range_start: "98", range: "2"},
          {destination_range_start: "52", source_range_start: "50", range: "48"}
        ],
        [
          {destination_range_start: "0", source_range_start: "15", range: "37"},
          {destination_range_start: "37", source_range_start: "52", range: "2"},
          {destination_range_start: "39", source_range_start: "0", range: "15"}
        ],
        [
          {destination_range_start: "49", source_range_start: "53", range: "8"},
          {destination_range_start: "0", source_range_start: "11", range: "42"},
          {destination_range_start: "42", source_range_start: "0", range: "7"},
          {destination_range_start: "57", source_range_start: "7", range: "4"}
        ],
        [
          {destination_range_start: "88", source_range_start: "18", range: "7"},
          {destination_range_start: "18", source_range_start: "25", range: "70"}
        ],
        [
          {destination_range_start: "45", source_range_start: "77", range: "23"},
          {destination_range_start: "81", source_range_start: "45", range: "19"},
          {destination_range_start: "68", source_range_start: "64", range: "13"}
        ],
        [
          {destination_range_start: "0", source_range_start: "69", range: "1"},
          {destination_range_start: "1", source_range_start: "0", range: "69"}
        ],
        [
          {destination_range_start: "60", source_range_start: "56", range: "37"},
          {destination_range_start: "56", source_range_start: "93", range: "4"}
        ]
      ]
    end
  end
end
