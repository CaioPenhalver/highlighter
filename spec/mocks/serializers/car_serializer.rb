# frozen_string_literal: true

class CarSerializer
  include Highlighter::JSON::Serializer

  attribute :id
  attribute :name, rename_to: :model
  attribute :manufacturer
end
