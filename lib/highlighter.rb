# frozen_string_literal: true

require_relative "highlighter/version"
require_relative "highlighter/json/attribute"
require_relative "highlighter/json/serializer"
require_relative "highlighter/json/serializers/object"
require_relative "highlighter/json/serializers/attribute"

module Highlighter
  class Error < StandardError; end
  # Your code goes here...
end
