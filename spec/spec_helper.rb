# frozen_string_literal: true

require "highlighter"
require "pry"

require_relative "mocks/models/car"
require_relative "mocks/models/address"
require_relative "mocks/models/user"
require_relative "mocks/serializers/car_serializer"
require_relative "mocks/serializers/address_serializer"
require_relative "mocks/serializers/user_serializer"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
