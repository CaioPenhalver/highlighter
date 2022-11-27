# frozen_string_literal: true

module Highlighter
  module CSV
    # Class that represents column
    class Column
      attr_reader :name

      def initialize(name:)
        @name = name
      end
    end
  end
end
