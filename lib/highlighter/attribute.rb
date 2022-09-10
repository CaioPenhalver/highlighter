# frozen_string_literal: true

module Highlighter
  # Holds info on attribute
  class Attribute
    attr_reader :field, :serializer, :rename_to, :block

    def initialize(field:, serializer: nil, rename_to: nil, &block)
      @field = field
      @serializer = serializer
      @rename_to = rename_to
      @block = block
    end

    def name
      rename_to.nil? ? field : rename_to
    end

    def block?
      !block.nil?
    end
  end
end
