# frozen_string_literal: true

require_relative "part_number_finder"

module PartNumberExtractor
  include PartNumberFinder

  def extract_part_numbers_from_row(row:, index:)
    return [] if row.nil?

    return [] unless has_part_number_at_or_next_to?(row:, index:)

    previous_characters = extract_part_number_ending_at(row:, index: index - 1)
    exact_opposite_character = row[index]
    next_characters = extract_part_number_starting_from(row:, index: index + 1)

    if exact_opposite_character.match?(/\d/)
      [
        [
          previous_characters,
          exact_opposite_character,
          next_characters
        ].join
      ]
    else
      [
        previous_characters,
        next_characters
      ]
    end
  end

  def extract_part_number_ending_at(row:, index:)
    extracted_parts = row[..index].reverse.take_while do |element|
      element.match?(/\d/)
    end

    extracted_parts.reverse.join
  end

  def extract_part_number_starting_from(row:, index:)
    extracted_parts = row[index..].take_while do |element|
      element.match?(/\d/)
    end

    extracted_parts.join
  end
end
