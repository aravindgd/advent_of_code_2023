class CardWorthCalculator
  def self.run(input)
    new(input).run
  end

  def initialize(input)
    @input = input
  end

  def run
    split_input = @input.split("\n")

    card_sets = split_input.map do |card_set_input|
      CardSet.from_input(card_set_input)
    end

    card_sets.map(&:points).sum
  end
end

class CardSet
  def initialize(our_hand:, winning_hand:)
    @our_hand = our_hand
    @winning_hand = winning_hand
  end

  def self.from_input(input)
    winning_hand, our_hand = input.gsub(/Card \d+:/, "").split("|")

    new(our_hand: our_hand, winning_hand: winning_hand)
  end

  def points
    return 0 if winning_card_count.zero?

    @points ||= begin
      total_points = 1

      (winning_card_count - 1).times do |t|
        total_points *= 2
      end

      total_points
    end
  end

  private

  attr_reader :our_hand, :winning_hand

  def winning_card_count
    @winning_card_count ||= structured_our_hand.count - non_winning_cards_count
  end

  def non_winning_cards_count
    @non_winning_cards_count ||= (structured_our_hand - structured_winning_hand).count
  end

  def structured_our_hand
    @structured_our_hand ||= our_hand.split
  end

  def structured_winning_hand
    @structured_winning_hand ||= winning_hand.split
  end
end
