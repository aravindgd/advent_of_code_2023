# frozen_string_literal: true

require_relative "part_number_extractor"
require_relative "symbol_finder"

class EngineParts
  def initialize(input)
    @input = input
  end

  def self.run(input)
    new(input).run
  end

  def run
    split_input = @input.split("\n").map(&:strip)

    schematic_rows = split_input.each_with_object([]) do |row, schematic_rows|
      previous_row = schematic_rows&.last&.row

      schematic_rows << SchematicRow.new(row:, previous_row:)
    end

    schematic_rows.sum(0) do |schematic_row|
      puts "**********"
      puts schematic_row.row
      puts schematic_row.previous_row
      puts "part_numbers: #{schematic_row.part_numbers}"
      puts "sum: #{schematic_row.part_numbers.map(&:to_i).sum}"
      schematic_row.part_numbers.map(&:to_i).sum
    end
  end
end

class SchematicRow
  include PartNumberExtractor
  include SymbolFinder

  attr_reader :row, :previous_row

  def initialize(row:, previous_row:)
    @row = row
    @previous_row = previous_row
  end

  def part_numbers
    @part_numbers ||= [
      find_numbers_based_on_row,
      find_numbers_based_on_previous_row
    ].flatten.compact.reject(&:empty?)
  end

  private

  def find_numbers_based_on_row
    index_of_symbols(row: structured_row) do |symbol_index|
      [
        extract_part_number_ending_at(row: structured_row, index: symbol_index - 1),
        extract_part_number_starting_from(row: structured_row, index: symbol_index + 1),
        extract_part_number_from_row(row: structured_previous_row, index: symbol_index)
      ]
    end
  end

  def find_numbers_based_on_previous_row
    return [] if previous_row.nil?

    index_of_symbols(row: structured_previous_row) do |symbol_index|
      extract_part_number_from_row(row: structured_row, index: symbol_index)
    end
  end

  def structured_row
    @structured_row ||= row.chars
  end

  def structured_previous_row
    return if previous_row.nil?

    @structured_previous_row ||= previous_row.chars
  end
end
