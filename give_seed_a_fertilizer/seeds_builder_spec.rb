require "rspec"

require_relative "seeds_builder"

describe SeedsBuilder do
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

  describe ".from_input_v1" do
    let(:subject) { described_class.from_input_v1(input) }

    it "returns the seeds" do
      expect(subject).to eq [79, 14, 55, 13]
    end
  end

  describe ".from_input_v2" do
    let(:subject) { described_class.from_input_v2(input) }

    it "returns seeds treating every first input as range start and every second input as range length" do
      expect(subject).to eq [
        79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67
      ]
    end
  end
end
