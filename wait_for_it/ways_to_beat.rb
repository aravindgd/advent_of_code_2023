class WaysToBeat
  def self.product(time_distance_map)
    new(time_distance_map).product
  end

  def initialize(time_distance_map)
    @time_distance_map = time_distance_map
  end

  def product
    @time_distance_map.reduce(1) do |product, (race_time, distance_to_beat)|
      product * self.class.ways_to_beat(race_time:, distance_to_beat:)
    end
  end

  def self.ways_to_beat(race_time:, distance_to_beat:)
    maximum_button_press_time = race_time - 1

    (1..maximum_button_press_time).count do |button_pressed_for|
      # boat accelerates to speed of how long the button is pressed for
      speed = button_pressed_for
      time_left_to_race = race_time - button_pressed_for

      distance_travelled = speed * time_left_to_race

      distance_travelled > distance_to_beat
    end
  end
end
