# frozen_string_literal: true

module Highlighter
  module Commands
    # Command to serialize object
    class ObjectSerializer
      def self.call(object:, attributes:, options:)
        new(object:, attributes:, options:).call
      end

      def initialize(object:, attributes:, options:)
        @object = object
        @attributes = attributes
        @options = options
      end

      def call
        attributes.each_with_object({}) do |attr, hash|
          hash[attr.name] = serialize_attribute(attr) if attr.show?(object, options)
          hash
        end
      end

      private

      attr_reader :object, :attributes, :options

      def serialize_attribute(attribute)
        AttributeSerializer.call(object:, attribute:, options:)
      end
    end
  end
end
