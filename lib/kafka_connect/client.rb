require 'faraday'
require 'faraday_middleware'
require 'kafka_connect/middleware/raise_http_exception'

require 'kafka_connect/rest/configs'
require 'kafka_connect/rest/connectors'
require 'kafka_connect/rest/tasks'
require 'kafka_connect/rest/request'

module KafkaConnect
  class Client
    include Rest::Configs
    include Rest::Connectors
    include Rest::Tasks
    include Rest::Request

    attr_accessor :base_uri

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
      @connection = Faraday.new(url: @base_uri, headers: default_headers, ssl: { verify: true}) do |builder|
        builder.use FaradayMiddleware::ParseJson, content_type: /\bjson$/
        # Currently the API does not use redirects (statuses in the 300 range), but the
        # use of these codes is reserved for future use so clients should handle them.
        # http://docs.confluent.io/2.0.0/connect/userguide.html
        builder.use FaradayMiddleware::FollowRedirects
        builder.use KafkaConnect::Middleware::RaiseHttpException
        builder.adapter Faraday.default_adapter
      end
    end

    private

    def default_headers
      {
        accept: 'application/json',
        content_type: 'application/json',
        user_agent: "Ruby Gem KafkaConnect #{KafkaConnect::VERSION}"
      }
    end
  end
end
