$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rspec/testrail'
require 'webmock/rspec'
require 'pry'
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

Dir[File.join(File.expand_path('..', __FILE__), 'support/**/*.rb')].each { |f| require f }
Dir[File.join(File.expand_path('..', __FILE__), 'helpers/**/*.rb')].each { |f| require f }

RSpec.configure do |config|

end
