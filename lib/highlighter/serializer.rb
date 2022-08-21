# frozen_string_literal: true

module Highlighter
  # Responsible for instantiating and serializing objects
  module Serializer
    def self.included(base)
      base.extend(ClassMethods)
    end

    def initialize(object, options = {})
      @object = object
      @options = options
    end

    def to_h
      return if @object.nil?

      Commands::ObjectSerializer.call(object: @object,
                                      attributes: self.class.attributes,
                                      options: @options)
    end
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
