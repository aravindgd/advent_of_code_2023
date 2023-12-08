class ScratchCard
  attr_reader :id
  attr_accessor :owned_copies_count

  def initialize(our_hand:, winning_hand:, id:)
    @id = id
    @our_hand = our_hand
    @winning_hand = winning_hand
    @owned_copies_count = 1
  end

  def self.from_input(input:, id:)
    winning_hand, our_hand = input.gsub(/Card \d+:/, "").split("|")

    new(our_hand:, winning_hand:, id:)
  end

  def points
    return 0 if winning_numbers_count.zero?

    @points ||= begin
      total_points = 1

      (winning_numbers_count - 1).times do |t|
        total_points *= 2
      end

      total_points
    end
  end

  def winning_numbers_count
    @winning_numbers_count ||= structured_our_hand.count - non_winning_cards_count
  end

  private

  attr_reader :our_hand, :winning_hand

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
