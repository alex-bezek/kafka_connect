module KafkaConnect
  class Base
    def initialize(client, attributes = {})
      # client is stored for future operations on the object such as editing it or deleting it.
      @client = client
      # create attr_reader for all key value pairs
      attributes.each do |k, v|
        instance_variable_set("@#{k.sub('.', '_')}", v) # Most config settigns have perids in the property names
        self.class.send(:attr_reader, k)
      end
    end
  end
end
