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
                                      attributes: self.class.attribute_list,
                                      options: @options)
    end
  end

  # Add methods to expose and set up attributes
  module ClassMethods
    def attribute(field, serializer: nil, rename_to: nil, &block)
      attribute_list << if block_given?
                          Attribute.new(field:, serializer:, rename_to:, &block)
                        else
                          Attribute.new(field:, serializer:, rename_to:)
                        end
    end

    def attributes(*fields)
      fields.each do |field|
        attribute_list << Attribute.new(field:)
      end
    end

    def attribute_list
      instance_variable_set(:@attribute_list, []) unless instance_variable_defined?(:@attribute_list)

      instance_variable_get(:@attribute_list)
    end
  end
end
