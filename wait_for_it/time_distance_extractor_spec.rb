require "rspec"
require_relative "time_distance_extractor"

describe TimeDistanceExtractor do
  let(:input) do
    <<~EOS
      Time:      7  15   30
      Distance:  9  40  200
    EOS
  end

  describe ".run" do
    subject { described_class.run(input) }

    it "returns a hash with time-distance pairs" do
      expect(subject).to eq({7 => 9, 15 => 40, 30 => 200})
    end
  end

  describe ".run_v2" do
    subject { described_class.run_v2(input) }

    it "returns a hash with a time-distance pair" do
      expect(subject).to eq({71530 => 940200})
    end
  end
end
