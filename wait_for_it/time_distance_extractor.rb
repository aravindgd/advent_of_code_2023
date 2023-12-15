class TimeDistanceExtractor
  def self.run(input)
    new(input).run
  end

  def self.run_v2(input)
    new(input).run_v2
  end

  def initialize(input)
    @lines = input.split("\n")
  end

  def run
    times = time_string.split.reject(&:empty?)
    distances = distance_string.split.reject(&:empty?)

    times.each_with_object({}).with_index do |(time, result), index|
      result[time.to_i] = distances[index].to_i
    end
  end

  def run_v2
    time = time_string.delete(" ")
    distance = distance_string.delete(" ")

    {time.to_i => distance.to_i}
  end

  private

  attr_reader :lines

  def time_string
    @time_string ||= lines[0].delete("Time:").strip
  end

  def distance_string
    @distance_string ||= lines[1].delete("Distance:").strip
  end
end
