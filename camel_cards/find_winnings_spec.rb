require "rspec"
require_relative "find_winnings"

describe FindWinnings do
  let(:input) do
    <<~INPUT
      32T3K 765
      T55J5 684
      KK677 28
      KTJJT 220
      QQQJA 483
    INPUT
  end

  describe ".run" do
    subject { described_class.run(input) }

    it "returns the total winnings from the hand" do
      expect(subject).to eq(6440)
    end
  end
end
