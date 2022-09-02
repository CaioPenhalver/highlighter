# frozen_string_literal: true

class UserSerializer
  include Highlighter::Serializer

  attribute :id
  attribute :name
  attribute :cars, serializer: CarSerializer
  attribute :address, serializer: ->(options) { options[:address_serializer] }
end
