$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rspec/testrail'
require 'pry'

RSpec.configure do |config|
  config.before(:all) do
    RSpec::Testrail.init url: 'http://test.site',
                         user: 'test@test.site',
                         password: ENV.fetch('TESTRAIL_PASSWORD', '12345678'),
                         project_id: 228,
                         suite_id: 1337
  end

  config.after(:each) do |example|
    binding.pry
  end
end
