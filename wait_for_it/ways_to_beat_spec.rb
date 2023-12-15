require "rspec"
require_relative "ways_to_beat"

describe WaysToBeat do
  describe ".product" do
    subject { described_class.product(time_distance_map) }

    let(:time_distance_map) do
      {7 => 9, 15 => 40, 30 => 200}
    end

    it "returns the product of number of ways to beat all the records" do
      expect(subject).to eq(288)
    end
  end

  describe ".ways_to_beat" do
    subject { described_class.ways_to_beat(race_time: 7, distance_to_beat: 9) }
  end
end
