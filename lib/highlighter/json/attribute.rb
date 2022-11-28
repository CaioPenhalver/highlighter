# frozen_string_literal: true

module Highlighter
  module JSON
    # Holds info on attribute
    class Attribute
      attr_reader :field, :serializer, :rename_to, :block, :show_if

      def initialize(field:, serializer: nil, rename_to: nil, show_if: nil, &block)
        @field = field
        @serializer = serializer
        @rename_to = rename_to
        @show_if = show_if
        @block = block
      end

      def name
        rename_to.nil? ? field : rename_to
      end

      def block?
        !block.nil?
      end

      def show?(object, options)
        return true unless show_if.is_a? Proc

        show_if.call(object, options)
      end
    end
  end
end
