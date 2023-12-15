require "rspec"
require_relative "time_distance_extractor"

describe TimeDistanceExtractor do
  let(:input) do
    <<~EOS
      Time:      7  15   30
      Distance:  9  40  200
    EOS
  end

  subject { described_class.run(input) }

  it "returns a hash with time-distance pairs" do
    expect(subject).to eq({7 => 9, 15 => 40, 30 => 200})
  end
end
