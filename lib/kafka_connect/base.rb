module KafkaConnect
  class Base
    def initialize(client, attributes = {})
      # client is stored for future operations on the object such as editing it or deleting it.
      @client = client
      # create attr_reader for all key value pairs
      attributes.each do |k, v|
        var_name = k.sub('.', '_')
        instance_variable_set("@#{var_name}", v) # Most config settings have periods in the property names
        self.class.send(:attr_reader, var_name)
      end
    end
  end
end
