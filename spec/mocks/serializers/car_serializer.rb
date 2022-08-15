# frozen_string_literal: true

class CarSerializer
  include Highlighter::Serializer

  attribute :id
  attribute :name
  attribute :manufacturer
end
