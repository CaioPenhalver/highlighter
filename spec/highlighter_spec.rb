# frozen_string_literal: true

RSpec.describe Highlighter do
  let(:address) { Address.new(id: 1, street: "street name", number: 345) }
  let(:cars) do
    3.times.map do |i|
      Car.new(id: i, name: "Name #{i}", manufacturer: "Company #{i}")
    end
  end
  let(:user) do
    User.new(id: 1,
             name: "Kelly",
             email: "kelly@mail.com",
             cars:, address:,
             bank_account: '123456',
             country: 'Brazil')
  end
  let(:user_serializer) do
    UserSerializer.new(user,
                       address_serializer: AddressSerializer,
                       bank_account: false)
  end

  subject { user_serializer.to_h }

  it "return serializable hash" do
    is_expected.to eql(
      {
        id: 1,
        name: "Kelly",
        email: "kelly@mail.com",
        address: { id: 1, number: 345, street: "street name" },
        description: "My name is Kelly and I have 3 cars",
        country: "Brazil",
        cars: [
          { id: 0, manufacturer: "Company 0", model: "Name 0" },
          { id: 1, manufacturer: "Company 1", model: "Name 1" },
          { id: 2, manufacturer: "Company 2", model: "Name 2" }
        ]
      }
    )
  end

  context "when there is nil value" do
    let(:user) do
      User.new(id: 1, name: nil, email: nil, cars: nil, address: nil, bank_account: nil, country: nil)
    end

    it "return serializable hash" do
      is_expected.to eql(
        {
          id: 1,
          name: nil,
          email: nil,
          cars: nil,
          address: nil,
          description: nil
        }
      )
    end
  end

  it "has a version number" do
    expect(Highlighter::VERSION).not_to be nil
  end
end
