class FindWinnings
  def self.run(input)
    new(input).run
  end

  def initialize(input)
    @input = input
  end

  def run
    hands = @input.split("\n").map do |line|
      Hand.from_input(line)
    end
  end
end

class Hand
  def self.from_input(line)
    cards_line, bet = line.split(" ")

    cards = cards_line.chars

    new(cards:, bet:)
  end

  def initialize(cards:, bet:)
    @cards = cards
    @bet = bet
  end

  def type
    @type ||= calculate_type
  end

  def calculate_type
    unique_cards = cards.uniq

    case unique_cards.size
    when 1
      #:five_of_a_kind
    when 2
      # first_unique_card = unique_cards[1]
      # if cards.count { |card| card == first_unique_card } == 4 || 1
      #   :four_of_a_kind
      # else
      #   :full_house
      # end
    when 3
    when 4
      #:one_pair
    when 5
      #:high_card
    end
  end
end
