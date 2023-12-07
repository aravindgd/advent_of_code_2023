module SymbolFinder
  # any symbol if symbol: nil
  def index_of_symbols(row:, symbol: nil)
    row.filter_map.with_index do |current_character, index|
      # is an integer or "."
      next if current_character.match?(/(\d|\.)/)

      next if symbol && current_character != symbol

      # is the right symbol
      if block_given?
        yield(index)
      else
        index
      end
    end
  end
end
