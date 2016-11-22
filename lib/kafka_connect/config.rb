require 'kafka_connect/base'

module KafkaConnect

  class Config < Base
    def initialize(connector, client, attributes = {})
      @connector = connector
      super client, attributes
    end

    def edit(properties = {})
      @client.edit_config @connector.name, properties
    end
  end
end
