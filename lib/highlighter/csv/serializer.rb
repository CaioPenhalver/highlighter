# frozen_string_literal: true

module Highlighter
  module CSV
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

        JSON::Serializers::Object.call(object: @object,
                                       attributes: self.class.attribute_list,
                                       options: @options)
      end
    end

    # Add methods to expose and set up attributes
    module ClassMethods
      def column(column, **options, &block)
        attribute_list << Attribute.new(column:,
                                        # extract_from: options[:extract_from],
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
end
