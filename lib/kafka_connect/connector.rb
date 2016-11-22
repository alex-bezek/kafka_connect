require 'kafka_connect/base'

module KafkaConnect
  class Connector < Base

    def initialize(client, attributes = {})
      @name = attributes.delete :name
      @config = Config.new(self, client, attributes.delete(:config)) if attributes.key? :config
      if attributes.key? :tasks
        @tasks = attributes.delete(:tasks).map { |task_attributes| Task.new(client, task_attributes) }
      end
      super client, attributes
    end

    def config
      @config ||= @client.config @name
    end

    def config!
      @client.config(@name).tap do |c|
        @config = c
      end
    end

    def tasks
      @tasks ||= @client.tasks @name
    end

    def tasks!
      @client.tasks(@name).tap do |c|
        @tasks = c
      end
    end

    def destroy!
      @client.delete_connector @name
      freeze
    end
  end
end
