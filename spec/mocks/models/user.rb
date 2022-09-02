# frozen_string_literal: true

class User
  attr_accessor :id, :name, :cars, :address

  def initialize(id:, name:, cars:, address:)
    @id = id
    @name = name
    @cars = cars
    @address = address
  end
end
