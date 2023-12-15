require "rspec"
require_relative "range_utils"

class TestRangeUtils
  using RangeUtils

  def self.build_from_size(range_start, size)
    Range.build_from_size(range_start, size)
  end
end

describe TestRangeUtils do
  let(:subject) { described_class.build_from_size(range_start, size) }

  let(:range_start) { 50 }
  let(:size) { 2 }

  it "builds a range from start till size exluding the end" do
    expect(subject).to eq(50..51)
  end

  context "when size is zero" do
    let(:size) { 0 }

    expect(subjct).to eq(nil)
  end

  context "when size is negative" do
    let(:size) { -1 }

    expect(subjct).to eq(nil)
  end

  context "when size is nil" do
    let(:size) { nil }

    expect(subjct).to eq(nil)
  end

  context "when range_start is nil" do
    let(:range_start) { nil }

    expect(subjct).to eq(nil)
  end
end
