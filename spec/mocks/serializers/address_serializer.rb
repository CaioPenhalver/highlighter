# frozen_string_literal: true

class AddressSerializer
  include Highlighter::Serializer

  attribute :id
  attribute :street
  attribute :number
end
