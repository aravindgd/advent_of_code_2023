class CubeGame
  attr_reader :red, :blue, :green, :input

  def initialize(red:, green:, blue:, input:)
    @red = red
    @blue = blue
    @green = green
    @input = input
  end

  def games
    split_input = input.split("\n").map(&:strip).reject(&:empty?)

    split_input.map do |game_data|
      structurize_game_data(game_data)
    end
  end

  def power_of_sets
    games.sum(&:power_of_sets)
  end

  def possible_games_id_sum
    bag = Bag.new(red:, green:, blue:)

    possible_games = games.select do |game|
      game.can_play?(bag)
    end

    possible_games.sum do |game|
      puts "******************"
      puts game.id
      game.id
    end
  end

  # eg: {1: [{red: 1, blue: 1}, {blue: 1, green: 1}]}
  def structurize_game_data(unstructured_game_data)
    game = Game.new

    # cut out game id from the string
    game_key = unstructured_game_data.slice!(/^Game \d+:/)
    game.id = game_key.slice!(/\d+/).to_i

    cube_count_by_set_and_color = unstructured_game_data.split(";") # ["blue 1, green 1", "green 1, red 1"]

    game.cube_sets = cube_count_by_set_and_color.map do |set|
      cube_set = CubeSet.new

      unstructured_cube_count_by_color = set.split(",") # ["blue 1", "green 2"]

      unstructured_cube_count_by_color.each do |cube_count_by_color|
        cube_count_by_color.strip! # cleanup empty spaces

        color = cube_count_by_color.match(/\D+/x)[0].strip
        count = cube_count_by_color.match(/\d+/x)[0].strip.to_i

        cube_set.public_send("#{color}=", count)
      end

      cube_set
    end

    game
  end
end

class Game
  attr_accessor :cube_sets, :id

  def initialize
    @cube_sets = nil
    @id = nil
  end

  # bag should have more cubes of a color than a set to be allowed
  def can_play?(bag)
    cube_sets.all? do |set|
      bag.red >= set.red && bag.green >= set.green && bag.blue >= set.blue
    end
  end

  def power_of_sets
    red_power_of_sets * blue_power_of_sets * green_power_of_sets
  end

  def red_power_of_sets
    cube_sets.map(&:red).max
  end

  def blue_power_of_sets
    cube_sets.map(&:blue).max
  end

  def green_power_of_sets
    cube_sets.map(&:green).max
  end
end

class CubeSet
  attr_accessor :red, :blue, :green

  def initialize
    @red = 0
    @green = 0
    @blue = 0
  end
end

class Bag
  attr_accessor :red, :blue, :green

  def initialize(red:, blue:, green:)
    @red = red
    @green = green
    @blue = blue
  end
end
