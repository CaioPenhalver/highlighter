# frozen_string_literal: true

class CarSerializer
  include Highlighter::Serializer

  attribute :id
  attribute :name, rename_to: :model
  attribute :manufacturer
end
