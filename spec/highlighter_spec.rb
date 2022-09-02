# frozen_string_literal: true

RSpec.describe Highlighter do
  let(:address) { Address.new(id: 1, street: "street name", number: 345) }
  let(:cars) do
    3.times.map do |i|
      Car.new(id: i, name: "Name #{i}", manufacturer: "Company #{i}")
    end
  end
  let(:user) { User.new(id: 1, name: "Kelly", cars:, address:) }
  let(:user_serializer) { UserSerializer.new(user, address_serializer: AddressSerializer) }

  subject { user_serializer.to_h }

  it "return serializable hash" do
    is_expected.to eql(
      {
        id: 1,
        name: "Kelly",
        address: { id: 1, number: 345, street: "street name" },
        cars: [
          { id: 0, manufacturer: "Company 0", name: "Name 0" },
          { id: 1, manufacturer: "Company 1", name: "Name 1" },
          { id: 2, manufacturer: "Company 2", name: "Name 2" }
        ]
      }
    )
  end

  context "when there is nil value" do
    let(:user) { User.new(id: 1, name: nil, cars: nil, address: nil) }

    it "return serializable hash" do
      is_expected.to eql(
        {
          id: 1,
          name: nil,
          cars: nil,
          address: nil
        }
      )
    end
  end

  it "has a version number" do
    expect(Highlighter::VERSION).not_to be nil
  end
end
