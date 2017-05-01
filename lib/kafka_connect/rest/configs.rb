require 'kafka_connect/rest/response'

module KafkaConnect
  module Rest
    module Configs
      include Response

      def config(name)
        parse get('/connectors/:name/config', name: name), KafkaConnect::Config
      end

      def edit_config(name, config)
        parse put('/connectors/:name/config', config.merge(name: name)), KafkaConnect::Config
      end
    end
  end
end
