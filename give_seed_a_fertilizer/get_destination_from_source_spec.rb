require "rspec"
require_relative "get_destination_from_source"
require_relative "planting_maps"

describe GetDestinationFromSource do
  describe ".run" do
    let(:subject) { described_class.run(source:, planting_map:) }

    let(:planting_map) do
      PlantingMaps::SeedToSoilMap.new(
        map_lines: [
          PlantingMaps::MapLine.new(source_range_start: 98, destination_range_start: 50, range: 2),
          PlantingMaps::MapLine.new(source_range_start: 50, destination_range_start: 52, range: 48)
        ]
      )
    end

    context "when source has a matching destination in map" do
      let(:source) { 79 }

      it "returns the destination number for the given source number" do
        expect(described_class.run(source:, planting_map:)).to eq 81
      end
    end

    context "when source does not have a matching destination in map" do
      let(:source) { 3 }

      it "returns the source number" do
        expect(described_class.run(source:, planting_map:)).to eq 3
      end
    end
  end
end
