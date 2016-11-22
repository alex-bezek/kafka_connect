# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kafka_connect/version'

Gem::Specification.new do |spec|
  spec.name          = 'kafka_connect'
  spec.version       = KafkaConnect::VERSION
  spec.authors       = ['Alex Bezek']
  spec.email         = ['alex.liam.bezek@gmail.com']
  #
  spec.summary       = 'A simple ruby rest client for interacting with the kafka-connect rest service'
  spec.description   = 'A simple ruby rest client for interacting with the kafka-connect rest service'
  spec.homepage      = 'https://github.com/alex-bezek/kafka_connect'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday_middleware', '~> 0.10'
  spec.add_dependency 'multi_json', '~> 1.12', '>= 1.12.1'
end
