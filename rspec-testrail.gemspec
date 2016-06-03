# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/testrail/version'

Gem::Specification.new do |spec|
  spec.name          = 'rspec-testrail'
  spec.version       = RSpec::Testrail::VERSION
  spec.authors       = ['Dmitry Zuev']
  spec.email         = ['d.zuev@rambler-co.ru']

  spec.summary       = 'RSpec integration with TestRail'
  spec.description   = 'rspec-testrail help you update statuses in TestRail app'
  spec.homepage      = 'https://github.com/dmitryzuev/rspec-testrail'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
                                        .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'webmock', '~> 2.1'

  spec.add_runtime_dependency 'rspec', '~> 3.0'
end
