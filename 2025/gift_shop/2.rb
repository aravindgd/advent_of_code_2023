# input = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

input = "132454-182049,42382932-42449104,685933-804865,5330496-5488118,21-41,289741-376488,220191-245907,49-70,6438484-6636872,2-20,6666660113-6666682086,173-267,59559721-59667224,307-390,2672163-2807721,658272-674230,485679-647207,429-552,72678302-72815786,881990-991937,73-111,416063-479542,596-934,32825-52204,97951700-98000873,18335-27985,70203-100692,8470-11844,3687495840-3687599608,4861-8174,67476003-67593626,2492-4717,1442-2129,102962-121710,628612213-628649371,1064602-1138912"

input.split(",").inject(0) do |sum_of_repeated_number_ids, range_str|
  start_str, end_str = range_str.split("-")
  range = start_str.to_i..end_str.to_i

  sum_of_repeated_number_ids += range.sum(0) do |num|
    number_str = num.to_s
    length_of_number = number_str.size
    half_length_of_number = length_of_number / 2

    next num if half_length_of_number.times.any? do |i|
      comparison_str = number_str[0..i]

      number_str.chars.each_slice(i + 1).all? do |slice|
        slice.join == comparison_str
      end
    end

    0
  end

  sum_of_repeated_number_ids
end
