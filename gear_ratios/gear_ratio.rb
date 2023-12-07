require_relative "symbol_finder"
require_relative "part_number_extractor"

class GearRatio
  include PartNumberExtractor

  def initialize(input)
    @input = input
  end

  def self.run(input)
    new(input).run
  end

  def run
    schema_diagram = SchemaDiagram.from_input(@input)

    schematic_rows = schema_diagram.schematic_rows

    # skipping first row since we need a number above a below the the "*" to be valid
    confirmed_part_numbers = schematic_rows[1..].filter_map do |schematic_row|
      next unless schematic_row.has_star_symbol?

      current_row = schematic_row.structured_row
      previous_row = schematic_rows[schematic_row.index - 1].structured_row
      next_row = schematic_rows[schematic_row.index + 1].structured_row

      schematic_row.star_symbol_indexes.filter_map do |symbol_index|
        part_numbers = extract_part_numbers_from_row(row: previous_row, index: symbol_index)

        part_numbers << extract_part_number_ending_at(row: current_row, index: symbol_index - 1)
        part_numbers << extract_part_number_starting_from(row: current_row, index: symbol_index + 1)

        part_numbers += extract_part_numbers_from_row(row: next_row, index: symbol_index)

        part_numbers = part_numbers.compact.reject(&:empty?)

        next if part_numbers.count != 2

        part_numbers.inject(1) do |product, part_number|
          product * part_number.to_i
        end
      end
    end

    confirmed_part_numbers.flatten.sum
  end
end

class SchemaDiagram
  attr_reader :schematic_rows

  def initialize(schematic_rows:)
    @schematic_rows = schematic_rows
  end

  def self.from_input(input)
    split_input = input.split("\n")

    schematic_rows = split_input.map.with_index do |row, index|
      SchematicRow.new(row:, index:)
    end

    new(schematic_rows:)
  end
end

class SchematicRow
  include SymbolFinder

  attr_reader :row, :index

  def initialize(row:, index:)
    @index = index
    @row = row
  end

  def structured_row
    @structured_row ||= row.chars
  end

  def has_star_symbol?
    star_symbol_indexes.any?
  end

  def star_symbol_indexes
    @star_symbol_indexes ||= index_of_symbols(row: structured_row, symbol: "*")
  end
end
