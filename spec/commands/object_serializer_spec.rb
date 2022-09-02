# frozen_string_literal: true

require "spec_helper"

RSpec.describe Highlighter::Commands::ObjectSerializer do
  subject { described_class.call(object:, attributes:, options:) }

  let(:address) { Struct.new("MockAddress", :street, :number).new("Street name", 99) }
  let(:object) { Struct.new("MockClass", :age, :name, :address).new(36, "John Wick", address) }
  let(:serializer) do
    Class.new do
      include Highlighter::Serializer

      attribute :street
      attribute :number
    end
  end
  let(:attributes) do
    [
      Highlighter::Attribute.new(name: :age),
      Highlighter::Attribute.new(name: :name),
      Highlighter::Attribute.new(name: :address, serializer:)
    ]
  end
  let(:options) { {} }
  let(:expected_response) do
    {
      name: "John Wick",
      age: 36,
      address: {
        street: "Street name",
        number: 99
      }
    }
  end

  it { is_expected.to eq expected_response }

  context "when options is passed on" do
    let(:address_serializer) do
      Class.new do
        include Highlighter::Serializer

        attribute :street
      end
    end
    let(:options) { { address_serializer: } }
    let(:serializer) { ->(options) { options[:address_serializer] } }
    let(:expected_response) do
      {
        name: "John Wick",
        age: 36,
        address: {
          street: "Street name"
        }
      }
    end

    it { is_expected.to eq expected_response }
  end
end
