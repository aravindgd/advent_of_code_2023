require "rspec"
require_relative "array_utils"

class TestArrayUtils
  using ArrayUtils

  def self.split_at(array:, value:)
    array.split_at_value(value)
  end
end

describe TestArrayUtils do
  let(:array) { [1, 2, 3, 4, 5, 6, 7, 8] }

  it "splits the array at the given value" do
    expect(described_class.split_at(array: array, value: 5)).to eq([[1, 2, 3, 4], [6, 7, 8]])
  end
end
