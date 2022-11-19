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
    def attribute(field, **options, &block)
      attribute_list << Attribute.new(field:,
                                      serializer: options[:serializer],
                                      rename_to: options[:rename_to],
                                      show_if: options[:if],
                                      &block)
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
