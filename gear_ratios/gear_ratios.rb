# frozen_string_literal: true

class GearRatios
  def initialize(input)
    @input = input
    @part_numbers = []
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
  attr_reader :row, :previous_row

  def initialize(row:, previous_row:)
    @row = row
    @previous_row = previous_row
  end

  def part_numbers
    @part_numbers ||= [
      find_numbers_next_to_symbol,
      find_numbers_in_row_by_symbol_in_previous_row,
      find_numbers_in_previous_row_by_symbol_in_row
    ].flatten.reject(&:empty?)
  end

  def find_numbers_next_to_symbol
    structured_row.map.with_index do |current_character, index|
      # is an integer or "."
      next if current_character.match?(/(\d|\.)/)

      # is a symbol
      [
        extract_part_number_from_previous_characters(structured_row, index: index - 1),
        extract_part_number_from_next_characters(structured_row, index: index + 1)
      ].compact.reject(&:empty?)
    end.flatten.compact
  end

  def find_numbers_in_row_by_symbol_in_previous_row
    return [] if previous_row.nil?

    structured_previous_row.map.with_index do |current_character, index|
      # is an integer or "."
      next if current_character.match?(/(\d|\.)/)

      # is a symbol
      extract_part_number_from_other_row(other_row: structured_row, index:)
    end.flatten.compact.reject(&:empty?)
  end

  def find_numbers_in_previous_row_by_symbol_in_row
    structured_row.map.with_index do |current_character, index|
      # is an integer or "."
      next if current_character.match?(/(\d|\.)/)

      # is a symbol
      extract_part_number_from_other_row(other_row: structured_previous_row, index:)
    end.flatten.compact.reject(&:empty?)
  end

  private

  def extract_part_number_from_other_row(other_row:, index:)
    # values at indices -1, 0, 1 from the index of symbol of the base row
    indices = [index - 1, index, index + 1]

    return unless other_row.values_at(*indices).any? { |character| character.match?(/\d/) }

    previous_characters = extract_part_number_from_previous_characters(other_row, index: index - 1)
    exact_opposite_character = other_row[index]
    next_characters = extract_part_number_from_next_characters(other_row, index: index + 1)

    if exact_opposite_character.match?(/\d/)
      [
        previous_characters,
        exact_opposite_character,
        next_characters
      ].join
    else
      [
        previous_characters,
        next_characters
      ]
    end
  end

  def extract_part_number_from_previous_characters(row_for_extraction, index:)
    extracted_parts = row_for_extraction[..index].reverse.take_while do |element|
      element.match?(/\d/)
    end

    extracted_parts.reverse.join
  end

  def extract_part_number_from_next_characters(row_for_extraction, index:)
    extracted_parts = row_for_extraction[index..].take_while do |element|
      element.match?(/\d/)
    end

    extracted_parts.join
  end

  def structured_row
    @structured_row ||= row.chars
  end

  def structured_previous_row
    return if previous_row.nil?

    @structured_previous_row ||= previous_row.chars
  end
end
