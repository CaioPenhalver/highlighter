# frozen_string_literal: true

class UserSerializer
  include Highlighter::Serializer

  attribute :id
  attribute :name
  attribute :cars, serializer: CarSerializer
end
