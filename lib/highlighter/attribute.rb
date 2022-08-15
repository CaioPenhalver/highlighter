# frozen_string_literal: true

module Highlighter
  # Holds info on attribute
  class Attribute
    attr_reader :name, :serializer

    def initialize(name:, serializer: nil)
      @name = name
      @serializer = serializer
    end
  end
end
