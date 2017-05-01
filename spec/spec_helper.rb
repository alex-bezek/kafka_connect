$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'kafka_connect'
require 'simplecov'
SimpleCov.start

Rspec.configure do |config|
  # disable soon to be depracted should syntax
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  stubbed_client = Faraday.new do |builder|
    builder.response :json
    builder.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get('/connectors') { |_env| [200, {}, ['connector1', 'connector2', 'connector3']] }
    end
  end

  config.before do
    allow(Faraday).to receive(:new).and_return(stubbed_client)
  end

  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
end
