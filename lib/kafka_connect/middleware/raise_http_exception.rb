require 'faraday'
require 'kafka_connect/error'

module KafkaConnect
  module Middleware
    class RaiseHttpException < Faraday::Middleware
      def call(env)
        @app.call(env).on_complete do |response|
          unless [200, 201, 204].include? response.status
            case response.status
            when 422 then raise KafkaConnect::UnprocessableEntity, response.body
            when 500 then raise KafkaConnect::InternalServerError, response.body
            else raise KafkaConnect::ResponseError, response.body
            end
          end
        end
      end

      def initialize(app)
        super app
        @parser = nil
      end
    end
  end
end
