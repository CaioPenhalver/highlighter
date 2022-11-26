# frozen_string_literal: true

class AddressSerializer
  include Highlighter::JSON::Serializer

  attribute :id
  attribute :street
  attribute :number
end
