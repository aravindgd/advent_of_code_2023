require "rspec"
require_relative "get_destination_from_source_range"
require_relative "planting_maps"

describe GetDestinationFromSourceRange do
  describe ".run" do
    let(:subject) { described_class.run(source_range:, planting_map:) }

    let(:planting_map) do
      PlantingMaps::SeedToSoilMap.new(
        map_lines: [
          PlantingMaps::MapLine.new(source_range_start: 98, destination_range_start: 50, range: 2),
          PlantingMaps::MapLine.new(source_range_start: 50, destination_range_start: 52, range: 48)
        ]
      )
    end

    context "when source range is covered by a matching destination in map" do
      let(:source_range) { 79..92 }

      it "returns the destination range for the given source range" do
        expect(subject).to eq 52..99
      end
    end

    context "when source range is not covered by a matching destination in map" do
      let(:source_range) { 1..3 }

      it "returns the source range" do
        expect(subject).to eq 1..3
      end
    end
  end

  describe "#get_possible_destination_ranges" do
    subject { described_class.new.get_possible_destination_ranges(seed_range:, map_line:) }

    context "when seed range and map line source range don't overlap" do
      let(:seed_range) { 40..60 }
      let(:map_line) { PlantingMaps::MapLine.new(source_range_start: 61, destination_range_start: 52, range: 10) }

      it "returns the seed range as destination range" do
        expect(subject).to eq [40..60]
      end
    end

    context "when seed range is a subset of map line source range" do
      let(:seed_range) { 40..60 }
      let(:map_line) { PlantingMaps::MapLine.new(source_range_start: 30, destination_range_start: 52, range: 31) }

      it "returns the corresponding destination range" do
        expect(subject).to eq [62..82]
      end
    end

    context "When map line source range is a subset of the seed range" do
      let(:seed_range) { 1..100 }
      let(:map_line) { PlantingMaps::MapLine.new(source_range_start: 40, destination_range_start: 52, range: 11) }

      it "returns the corresponding destination ranges" do
        expect(subject).to eq [1..39, 52..62, 51..100]
      end
    end

    context "When seed range doesn't being inside map line source range but ends inside it" do
      let(:seed_range) { 30..70 }
      let(:map_line) { PlantingMaps::MapLine.new(source_range_start: 50, destination_range_start: 100, range: 51) }

      it "returns the corresponding destination ranges" do
        expect(subject).to eq [30..49, 100..120]
      end
    end

    context "when seed range begins inside map line source range but doesn't end inside it" do
      let(:seed_range) { 30..100 }
      let(:map_line) { PlantingMaps::MapLine.new(source_range_start: 30, destination_range_start: 100, range: 21) }

      it "returns the corresponding destination ranges" do
        expect(subject).to eq [100..120, 51..100]
      end
    end
  end
end
