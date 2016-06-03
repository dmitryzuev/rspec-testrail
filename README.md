# RSpec::Testrail


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-testrail'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-testrail

## Usage

```ruby
# spec/spec_helper

require 'rspec/testrail'

RSpec.configure do |config|

  config.before(:all) do
    # Uncomment if you are using gem `webmock`
    # WebMock.allow_net_connect!
    RSpec::Testrail.init url: 'http://test.site',
                         user: 'test@test.site',
                         password: ENV.fetch('TESTRAIL_PASSWORD', '12345678')
  end

  config.after(:example), testrail_id: proc { |value| !value.nil? } do |example|
    # Uncomment if you are using gem `webmock`
    # WebMock.allow_net_connect!
    RSpec::Testrail.process(example)
  end
end
```

```ruby
# spec/models/user_spec.rb

RSpec.describe User, type: :model do
  it 'is invalid without email', testrail_id: 31_337 do
    # ...
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dmitryzuev/rspec-testrail. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
