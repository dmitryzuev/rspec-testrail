$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rspec/testrail'
require 'webmock/rspec'
require 'pry'

Dir[File.join(File.expand_path('..', __FILE__), 'support/**/*.rb')].each { |f| require f }
Dir[File.join(File.expand_path('..', __FILE__), 'helpers/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.before(:all) do
    RSpec::Testrail.init url: 'http://test.site',
                         user: 'test@test.site',
                         password: ENV.fetch('TESTRAIL_PASSWORD', '12345678'),
                         project_id: 228,
                         suite_id: 1337,
                         run_name: `git rev-parse --abbrev-ref HEAD`.strip,
                         run_description: `git rev-parse HEAD`.strip
  end
end
