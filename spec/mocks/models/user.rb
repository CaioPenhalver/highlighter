# frozen_string_literal: true

class User
  attr_accessor :id, :name, :cars, :address, :email

  def initialize(id:, name:, email:, cars:, address:)
    @id = id
    @name = name
    @email = email
    @cars = cars
    @address = address
  end
end
