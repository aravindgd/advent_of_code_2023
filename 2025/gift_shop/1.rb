input = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

input.split(",").inject(0) do |sum_of_ids_repeated_twice, range_str|
  start_str, end_str = range_str.split("-")
  range = start_str.to_i..end_str.to_i

  sum_of_ids_repeated_twice += range.sum(0) do |num|
    number_str = num.to_s.chars
    length_of_number = number_str.size

    half_length_of_number, halving_modulo = length_of_number.divmod(2)

    next 0 if length_of_number < 2 || halving_modulo != 0

    next 0 if number_str[0..half_length_of_number - 1] != number_str[half_length_of_number..-1]

    num
  end

  ids_repeated_twice
end
