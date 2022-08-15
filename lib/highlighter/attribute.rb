# frozen_string_literal: true

module Highlighter
  class Attribute
    attr_reader :name, :serializer

    def initialize(name:, serializer: nil)
      @name = name
      @serializer = serializer
    end
  end
end
