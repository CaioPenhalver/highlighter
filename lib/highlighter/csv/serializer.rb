# frozen_string_literal: true

require "csv"

module Highlighter
  module CSV
    # Responsible for instantiating and serializing objects
    module Serializer
      def self.included(base)
        base.extend(ClassMethods)
      end

      def initialize(list, options = {})
        @list = list
        @options = options
      end

      def to_csv
        return if @list.nil? || @list.empty?

        headers = self.class.column_list.map(&:name)
        ::CSV.generate(write_headers: true, headers:) do |csv|
          @list.map do |object|
            csv << headers.map { |h| object.send(h) }
          end
        end
      end

      # JSON::Serializers::Object.call(object: @object,
      #                                attributes: self.class.attribute_list,
      #                                options: @options)
    end

    # Add methods to expose and set up attributes
    module ClassMethods
      def column(name, **_options)
        column_list << Column.new(name:) # ,
        # extract_from: options[:extract_from],
        # show_if: options[:if],
        # &block)
      end

      def columns(*names)
        names.each { |name| column_list << Column.new(name:) }
      end

      def column_list
        instance_variable_set(:@column_list, []) unless instance_variable_defined?(:@column_list)

        instance_variable_get(:@column_list)
      end
    end
  end
end
