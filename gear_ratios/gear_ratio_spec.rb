# frozen_string_literal: true

require "rspec"
require_relative "gear_ratio"

describe GearRatio do
  subject { described_class.run(input) }

  let(:input) do
    <<~EOS
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
    EOS
  end

  it "returns the gear ratio" do
    expect(subject).to eq 467835
  end
end
