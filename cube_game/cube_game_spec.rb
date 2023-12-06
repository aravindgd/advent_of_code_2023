require 'rspec'
require './cube_game'

describe CubeGame do

  let(:input) do
    "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
     Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
     Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
     Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
     Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    "
  end 

  context "possible_games_id_sum" do
    subject { described_class.new(input:, red: 12, green: 13, blue: 14).possible_games_id_sum }

    it "adds the id of the eligible games and return the sum" do
      expect(subject).to eq 8
    end
  end

  context "power_of_sets" do
    subject { described_class.new(input:, red: 12, green: 13, blue: 14).power_of_sets }

    it "adds the id of the eligible games and return the sum" do
      expect(subject).to eq 2286
    end
  end
end
