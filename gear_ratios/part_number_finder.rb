module PartNumberFinder
  def has_part_number_at_or_next_to?(row:, index:)
    # values at indices -1, 0, 1
    indices = [index - 1, index, index + 1]

    row.values_at(*indices).any? { |character| character.match?(/\d/) }
  end
end
