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
             bank_account: "123456",
             country: "Brazil")
  end
  let(:user_serializer) do
    UserSerializer.new(user,
                       address_serializer: AddressSerializer,
                       show_bank_account:)
  end
  let(:show_bank_account) { true }

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
        bank_account: "123456",
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
          bank_account: nil,
          address: nil,
          description: nil
        }
      )
    end
  end

  context "when field is not shown" do
    let(:show_bank_account) { false }

    it "return serializable hash" do
      is_expected.not_to include(:bank_account)
    end
  end

  context "when serialising to CSV" do
    let(:users) do
      [
        User.new(id: 1,
                 name: "Kelly",
                 email: "kelly@mail.com",
                 cars:, address:,
                 bank_account: "123456",
                 country: "Brazil"),
        User.new(id: 2,
                 name: "Alice",
                 email: "alice@mail.com",
                 cars:, address:,
                 bank_account: "123456",
                 country: "Brazil")
      ]
    end
    let(:user_serializer) do
      UserCsvSerializer.new(users)
    end

    subject { user_serializer.to_csv }

    it "return serializable CSV" do
      is_expected.to eql(
        "id,name,email\n" \
        "1,Kelly,kelly@mail.com\n" \
        "2,Alice,alice@mail.com\n"
      )
    end
  end

  it "has a version number" do
    expect(Highlighter::VERSION).not_to be nil
  end
end
