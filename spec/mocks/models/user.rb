# frozen_string_literal: true

class User
  attr_accessor :id, :name, :cars, :address, :email, :bank_account, :country

  def initialize(id:, name:, email:, cars:, address:, bank_account:, country:) # rubocop:disable Metrics/ParameterLists
    @id = id
    @name = name
    @email = email
    @cars = cars
    @address = address
    @bank_account = bank_account
    @country = country
  end
end
