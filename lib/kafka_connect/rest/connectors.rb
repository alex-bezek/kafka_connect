require 'kafka_connect/rest/response'

module KafkaConnect
  module Rest
    module Connectors
      include Response

      def connectors
        resp = get '/connectors'
        resp.body.map { |item| Connector.new(self, name: item) }
      end

      def connector(name)
        parse get('/connectors/:name', name: name), KafkaConnect::Connector
      end

      def create_connector(name, config = {})
        parse post('/connectors', config.merge(name: name)), KafkaConnect::Connector
      end

      def delete_connector(name)
        resp = delete '/connectors/:name', name: name
        !!(resp.status == 204)
      end
    end
  end
end
