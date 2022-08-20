# frozen_string_literal: true

module Highlighter
  # Responsible for instantiating and serializing objects
  module Serializer
    def self.included(base)
      base.extend(ClassMethods)
    end

    def initialize(object)
      @object = object
    end

    def to_h
      return if @object.nil?

      self.class.attributes.each_with_object({}) do |attr, hash|
        hash[attr.name] = serialize_attribute(attr)
        hash
      end
    end

    def serialize_attribute(attr)
      value = @object.send(attr.name)
      return serialize_array(value, attr) if value.instance_of? Array

      apply_serializer(value, attr)
    end

    def serialize_array(array, attr)
      array.map do |value|
        apply_serializer(value, attr)
      end
    end

    def apply_serializer(value, attr)
      return value if attr.serializer.nil?

      attr.serializer.new(value).to_h
    end

    # Add methods to expose and set up attributes
    module ClassMethods
      def attribute(name, serializer: nil)
        instance_variable_set(:@attributes, []) unless instance_variable_defined?(:@attributes)
        instance_variable_get(:@attributes) << Attribute.new(name:, serializer:)
      end

      def attributes
        instance_variable_get(:@attributes)
      end
    end
  end
end
