class TimeDistanceExtractor
  def self.run(input)
    @input = input

    lines = input.split("\n")
    time_string = lines[0].delete("Time:").strip
    distance_string = lines[1].delete("Distance:").strip

    times = time_string.split.reject(&:empty?)
    distances = distance_string.split.reject(&:empty?)

    times.each_with_object({}).with_index do |(time, result), index|
      result[time.to_i] = distances[index].to_i
    end
  end
end
