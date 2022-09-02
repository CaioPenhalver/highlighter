# frozen_string_literal: true

class Address
  attr_accessor :id, :street, :number

  def initialize(id:, street:, number:)
    @id = id
    @street = street
    @number = number
  end
end
