# frozen_string_literal: true

class UserSerializer
  include Highlighter::Serializer

  attributes :name, :email

  attribute :id
  attribute :cars, serializer: CarSerializer
  attribute :address, serializer: ->(options) { options[:address_serializer] }
end
