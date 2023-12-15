# frozen_string_literal: true

require "rspec"

require_relative "closest_planting_location_finder"
require_relative "planting_map_builder"
require_relative "seeds_builder"

describe ClosestPlantingLocationFinder do
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

  context "when working with a collection of seeds" do
    let(:subject) { described_class.run(seeds:, planting_maps:) }

    let(:seeds) { SeedsBuilder.from_input_v1(input) }
    let(:planting_maps) { PlantingMapBuilder.from_input(input) }

    it "returns the closest location to plant" do
      expect(subject).to eq 35
    end
  end

  context "when working with a collection of seed ranges" do
    let(:subject) { described_class.run(seeds:, planting_maps:, seed_range: true) }

    let(:seeds) { SeedsBuilder.from_input_v2(input) }
    let(:planting_maps) { PlantingMapBuilder.from_input(input) }

    it "returns the closest location to plant" do
      expect(subject).to eq 46
    end
  end
end
