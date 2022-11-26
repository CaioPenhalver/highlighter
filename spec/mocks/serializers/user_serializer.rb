# frozen_string_literal: true

class UserSerializer
  include Highlighter::JSON::Serializer

  attributes :name, :email

  attribute :id
  attribute :cars, serializer: CarSerializer
  attribute :address, serializer: ->(options) { options[:address_serializer] }
  attribute :description do |object|
    object.name.nil? ? nil : "My name is #{object.name} and I have #{object.cars.count} cars"
  end
  attribute :bank_account, if: ->(_object, options) { options[:show_bank_account] }
  attribute :country, if: ->(object, _options) { !object.country.nil? }
end
