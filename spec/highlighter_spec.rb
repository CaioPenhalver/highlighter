# frozen_string_literal: true

RSpec.describe Highlighter do
  let(:cars) do
    3.times.map do |i|
      Car.new(id: i, name: "Name #{i}", manufacturer: "Company #{i}")
    end
  end
  let(:user) { User.new(id: 1, name: "Kelly", cars:) }
  let(:user_serializer) { UserSerializer.new(user) }

  subject { user_serializer.serializable_hash }

  it "return serializable hash" do
    is_expected.to eql(
      {
        id: 1,
        name: "Kelly",
        cars: [
          { id: 0, manufacturer: "Company 0", name: "Name 0" },
          { id: 1, manufacturer: "Company 1", name: "Name 1" },
          { id: 2, manufacturer: "Company 2", name: "Name 2" }
        ]
      }
    )
  end

  it "has a version number" do
    expect(Highlighter::VERSION).not_to be nil
  end
end
