# frozen_string_literal: true

class TrebuchetV2
  def initialize(input)
    @input = input
  end

  def self.run(input)
    self.new(input).run
  end

  def run
    split_input = @input.split("\n").map(&:strip)

    split_into_numbers = split_input.map do |input_string|
      output = SplitIntoStringNumbers.run(input_string)
      puts "#{input_string} => #{output}"
      puts "**********"
      output
    end


    final_sum = split_into_numbers.reduce(0) do |sum, number_array|
      sum + (number_array[0] + number_array[-1]).to_i
    end

    puts final_sum

    final_sum
  end
end

class SplitIntoStringNumbers
  NUMBERS_WORD_HASH = {
    "one" => "1", "two" => "2", "three" => "3", "four" => "4", "five" => "5",
    "six" => "6", "seven" => "7", "eight" => "8", "nine" => "9", "ten" => "10"
  }.freeze

  def self.run(input)
    scrubbed_input = input

    one_of_the_word_numbers = NUMBERS_WORD_HASH.keys.join("|")

    final_data = []

    loop do
      break if scrubbed_input == ""

      # find the first word number or an integer
      match_data = scrubbed_input.match(/^(#{one_of_the_word_numbers}|\d)/)

      if match_data.nil?
        # remove the first character if there are no matches
        # this is in case there are illegal or bad characters
        # that obfuscate a real word number. eg: aaaone, oneaab
        scrubbed_input = scrubbed_input[1..-1]
      else
        matched_string = match_data[0]

        final_data << matched_string

        # the last letter of the matched string
        # and left over string post the match
        # if input = oneeight || 1eight
        # and match_string = eight
        scrubbed_input =  if is_matched_string_a_number?(matched_string)
          match_data.post_match
        else
          matched_string[-1] + match_data.post_match
        end
      end
    end

    final_data.map do |data|
      NUMBERS_WORD_HASH[data] || data
    end
  end

  def self.is_matched_string_a_number?(string)
    string.to_i > 0
  end
end
