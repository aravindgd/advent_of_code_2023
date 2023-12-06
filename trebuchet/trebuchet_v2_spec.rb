require 'rspec'
require_relative './trebuchet_v2'

RSpec.describe TrebuchetV2 do
  describe '.run' do
    subject { described_class.run(input) }

    let(:input) do
      "two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen"
    end

    it 'returns the sum of first and last number including numbers as words' do
      expect(subject).to eq(281)
    end
  end
end

RSpec.describe SplitIntoStringNumbers do
  describe '.run' do
    subject { described_class.run(input) }

    context "when there are both word numbers and numbers" do
      let(:input) do
        "two1nine"
      end

      it 'returns all of word and digit numbers' do
        expect(subject).to eq(["2", "1", "9"])
      end
    end

    context "when there word numbers starting from ending of other word numbers" do
      let(:input) { "eightwothree" }

      it "returns all the numbers" do
        expect(subject).to eq ["8", "2", "3"]
      end
    end

    context "when there are random words/characters at the beginning and end" do
      let(:input) { "abcone2threexyz" }

      it "ignores the random characters and returns the numbers" do
        expect(subject).to eq ["1", "2", "3"]
      end
    end

    context "when there are random words/characters at the beginning" do
      let(:input) { "xtwone3four" }

      it "ignores the random characters and returns the numbers" do
        expect(subject).to eq ["2", "1", "3", "4"]
      end
    end

    context "when there are numbers at the first and last, and word numbers in between" do
      let(:input) { "4nineeightseven2" }

      it "returns the numbers" do
        expect(subject).to eq ["4", "9", "8", "7", "2"]
      end
    end

    context "when there are non legal word numbers" do
      let(:input) { "7pqrstsixteen" }

      it "returns legal numbers only" do
        expect(subject).to eq ["7", "6"]
      end
    end
  end
end
