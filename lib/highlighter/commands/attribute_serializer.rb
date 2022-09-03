# frozen_string_literal: true

module Highlighter
  module Commands
    # Command to serialize attribute
    class AttributeSerializer
      def self.call(object:, attribute:, options: {})
        new(object:, attribute:, options:).call
      end

      def initialize(object:, attribute:, options:)
        @object = object
        @attribute = attribute
        @options = options
      end

      def call
        value = object.send(attribute.field)
        return serialize_array(value) if value.instance_of? Array

        apply_serializer(value, attribute)
      end

      private

      attr_reader :object, :attribute, :options

      def serialize_array(array)
        array.map do |value|
          apply_serializer(value, attribute)
        end
      end

      def apply_serializer(value, attr)
        serializer = attr.serializer
        return value if serializer.nil?

        serializer = serializer.call(options) if serializer.is_a? Proc

        serializer.new(value).to_h
      end
    end
  end
end
