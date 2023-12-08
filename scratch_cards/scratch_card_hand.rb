require_relative "scratch_card"

class ScratchCardHand
  def self.total_points(input)
    new(input).total_points
  end

  def self.number_of_cards_owned(input)
    new(input).number_of_cards_owned
  end

  def initialize(input)
    @input = input
  end

  def total_points
    scratch_cards.map(&:points).sum
  end

  def number_of_cards_owned
    scratch_cards.each do |scratch_card|
      next if scratch_card.winning_numbers_count.zero?

      # you always own at least one copy of card in question
      scratch_card.owned_copies_count.times do
        index_of_next_scratch_card = scratch_card.id

        scratch_card.winning_numbers_count.times do
          break if index_of_next_scratch_card >= scratch_cards.count

          next_scratch_card = scratch_cards[index_of_next_scratch_card]

          next_scratch_card.owned_copies_count += 1

          index_of_next_scratch_card += 1
        end
      end
    end

    scratch_cards.map(&:owned_copies_count).sum
  end

  private

  def scratch_cards
    @scratch_cards ||= @input.split("\n").map.with_index do |scratch_card_input, index|
      ScratchCard.from_input(input: scratch_card_input, id: index + 1)
    end
  end
end
