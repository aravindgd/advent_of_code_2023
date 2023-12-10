require_relative 'input_builder'

class SeedsBuilder
  def self.from_input_v1(input)
    new(input).from_input_v1
  end

  def initialize(input)
    @input = input
  end

  def from_input_v1
    data
  end

  def data
    InputBuilder.seeds_input(input)
  end

  private attr_reader :input
end
