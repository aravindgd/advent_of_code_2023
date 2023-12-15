require_relative "input_builder"
require_relative "../range_utils"

class SeedsBuilder
  using RangeUtils

  def self.from_input_v1(input)
    new(input).from_input_v1
  end

  def self.from_input_v2(input)
    new(input).from_input_v2
  end

  def initialize(input)
    @input = input
  end

  def from_input_v2
    data.each_slice(2).map do |range_start, size|
      Range.build_from_size(range_start, size)
    end
  end

  def from_input_v1
    data
  end

  def data
    @data ||= InputBuilder.seeds_input(input)
  end

  private attr_reader :input
end
