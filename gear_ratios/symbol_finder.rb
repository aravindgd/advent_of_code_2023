module SymbolFinder
  def index_of_symbols(row:)
    row.map.with_index do |current_character, index|
      # is an integer or "."
      next if current_character.match?(/(\d|\.)/)

      # is a symbol
      yield(index)
    end
  end
end
