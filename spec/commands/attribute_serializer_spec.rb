# frozen_string_literal: true

require "spec_helper"

RSpec.describe Highlighter::Commands::AttributeSerializer do
  subject { described_class.call(object:, attribute:, options:) }
  let(:options) { {} }

  context "when it is a number" do
    let(:object) { Struct.new("MockClass", :age).new(36) }
    let(:attribute) { Highlighter::Attribute.new(field: "age") }

    it { is_expected.to eq 36 }
  end

  context "when it is a string" do
    let(:object) { Struct.new("MockClass", :full_name).new("John Wick") }
    let(:attribute) { Highlighter::Attribute.new(field: "full_name") }

    it { is_expected.to eq "John Wick" }
  end

  context "when block is given" do
    let(:object) { Struct.new("MockClass", :full_name).new("John Wick") }
    let(:attribute) do
      Highlighter::Attribute.new(field: "full_name") do |object|
        "I'm #{object.full_name}"
      end
    end

    it { is_expected.to eq "I'm John Wick" }
  end

  context "whent it is an array" do
    let(:names) { ["John Wick", "Rambo"] }
    let(:object) { Struct.new("MockClass", :names).new(names) }
    let(:attribute) { Highlighter::Attribute.new(field: "names") }
    let(:options) { {} }

    it { is_expected.to eq ["John Wick", "Rambo"] }

    context "when items are objects" do
      let(:mock_item) { Struct.new("MockClass", :full_name) }
      let(:names) { [mock_item.new("John Wick"), mock_item.new("Rambo")] }
      let(:object) { Struct.new("MockClass", :names).new(names) }
      let(:serializer) do
        Class.new do
          include Highlighter::Serializer

          attribute :full_name
        end
      end
      let(:attribute) { Highlighter::Attribute.new(field: "names", serializer:) }
      let(:options) { {} }

      it { is_expected.to eq [{ full_name: "John Wick" }, { full_name: "Rambo" }] }

      context "when serializer is a lambda" do
        let(:name_serializer) do
          Class.new do
            include Highlighter::Serializer

            attribute :full_name
          end
        end
        let(:options) { { name_serializer: } }
        let(:serializer) { ->(options) { options[:name_serializer] } }

        it { is_expected.to eq [{ full_name: "John Wick" }, { full_name: "Rambo" }] }
      end
    end
  end
end
