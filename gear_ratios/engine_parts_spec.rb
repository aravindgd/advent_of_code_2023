# frozen_string_literal: true

require "rspec"
require_relative "engine_parts"

describe EngineParts do
  subject { described_class.run(input) }

  let(:input) do
    "467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598.."
  end

  it "returns the sum of numbers diagonally or next to a symbol" do
    expect(subject).to eq 4361
  end
end

describe SchematicRow do
  describe ".find_numbers_next_to_symbol" do
    subject { described_class.new(row:, previous_row:).part_numbers }

    let(:previous_row) { nil }

    context "when symbol is after numbers" do
      let(:row) do
        "617*......"
      end

      it "returns the numbers next to the symbol" do
        expect(subject).to eq ["617"]
      end
    end

    context "when symbol is before numbers" do
      let(:row) do
        "*617......"
      end

      it "returns the numbers next to the symbol" do
        expect(subject).to eq ["617"]
      end
    end

    context "when symbol is before numbers and one after the numbers" do
      let(:row) do
        "*617...21*"
      end

      it "returns the numbers next to the symbol" do
        expect(subject).to eq ["617", "21"]
      end
    end

    context "when symbol is between two numbers" do
      let(:row) do
        "617*21...32."
      end

      it "returns the numbers next to the symbol" do
        expect(subject).to eq ["617", "21"]
      end
    end

    context "when no symbol is present" do
      let(:row) do
        "617221...32."
      end

      it "returns the numbers next to the symbol" do
        expect(subject).to eq []
      end
    end

    context "when symbol has a diagonal number one spot before in previous row" do
      let(:row) do
        "...*......"
      end

      let(:previous_row) do
        "467..114.."
      end

      it "returns the numbers diagonal to the symbol" do
        expect(subject).to eq ["467"]
      end
    end

    context "when symbol has a diagonal number one spot after in previous row" do
      let(:row) do
        "...*......"
      end

      let(:previous_row) do
        "....1114.."
      end

      it "returns the numbers diagonal to the symbol" do
        expect(subject).to eq ["1114"]
      end
    end

    context "when symbol has a diagonal number one spot before and one spot after in previous row" do
      let(:row) do
        "...*......"
      end

      let(:previous_row) do
        "467.1114.."
      end

      it "returns the numbers diagonal to the symbol" do
        expect(subject).to eq ["467", "1114"]
      end
    end

    context "when symbol has a straight opposite number in previous row" do
      let(:row) do
        "...*......"
      end

      let(:previous_row) do
        ".6746.14.."
      end

      it "returns the numbers" do
        expect(subject).to eq ["6746"]
      end
    end

    context "when symbol has no diagonal or opposite number in previous row" do
      let(:row) do
        "...*......"
      end

      let(:previous_row) do
        ".6*...14.."
      end

      it "returns the numbers" do
        expect(subject).to eq []
      end
    end
  end
end
