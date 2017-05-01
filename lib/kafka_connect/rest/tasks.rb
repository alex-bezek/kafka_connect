require 'kafka_connect/rest/response'

module KafkaConnect
  module Rest
    module Tasks
      include Response

      def tasks(name)
        parse get('/connectors/:name/tasks', name: name), KafkaConnect::Task
      end
    end
  end
end
