# Highlighter

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/highlighter`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'highlighter'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install highlighter

## Usage

```ruby
class User
  attr_accessor :id, :name, :cars

  def initialize(id:, name:, cars:)
    @id = id
    @name = name
    @cars = cars
  end
end
```
```ruby
class Car
  attr_accessor :id, :name, :manufacturer

  def initialize(id:, name:, manufacturer:)
    @id = id
    @name = name
    @manufacturer = manufacturer
  end
end
```
Then, we should define one serializer for each class:
```ruby
class CarSerializer
  include Highlighter::Serializer

  attribute :id
  attribute :name
  attribute :manufacturer
end
```
```ruby
class UserSerializer
  include Highlighter::Serializer

  attribute :id
  attribute :name
  attribute :cars, serializer: CarSerializer
end
```
```ruby
cars = [
      Car.new(id: 1, name: 'Polo', manufacturer: 'VW'),
      Car.new(id: 2, name: 'Focus', manufacturer: 'Ford')
    ]
user = User.new(id: 1, name: "Kelly", cars: cars)
```
Now that we have the instances of cars and user in place we just need to instatiate the serializer and call `to_h`
```ruby
UserSerializer.new(user).to_h
```
And it will return:
```ruby
{
  id: 1,
  name: "Kelly",
  cars: [
          { id: 0, manufacturer: 'Polo', name: 'VW' },
          { id: 1, manufacturer: 'Focus', name: 'Ford' },
        ]
}
```
It also supports lambdas to set serializer on the fly:
```ruby
class UserSerializer
  include Highlighter::Serializer

  attribute :id
  attribute :name
  attribute :cars, serializer: ->(options) { options[:custom_serializer] }
end
```
```ruby
UserSerializer.new(user, custom_serializer: CarSerializer).to_h
```
Renaming attribute:
```ruby
class UserSerializer
  include Highlighter::Serializer

  attribute :id
  attribute :name, rename_to: :full_name
end
```
```ruby
{
  id: 1,
  full_name: "Kelly"
}
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/CaioPenhalver/highlighter.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
