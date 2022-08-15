# frozen_string_literal: true

class Car
  attr_accessor :id, :name, :manufacturer

  def initialize(id:, name:, manufacturer:)
    @id = id
    @name = name
    @manufacturer = manufacturer
  end
end
