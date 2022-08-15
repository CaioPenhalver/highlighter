# frozen_string_literal: true

class User
  attr_accessor :id, :name, :cars

  def initialize(id:, name:, cars:)
    @id = id
    @name = name
    @cars = cars
  end
end
