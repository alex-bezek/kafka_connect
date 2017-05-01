module KafkaConnect
  module Rest
    module Response
      def parse(response, object_class)
        # Do nothing if the body is an empty hash, empty array, or nill
        return response.body if [{}, [], nil].include? response.body
        if response.body.class == Hash
          object_class.new(self, response.body)
        else
          response.body.each { |item| object_class.new(self, item) }
        end
      end
    end
  end
end
