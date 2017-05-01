require 'multi_json'

module KafkaConnect
  module Rest
    module Request
      def get(path, options = {})
        request(:get, path, options)
      end

      def post(path, options)
        request(:post, path, options)
      end

      def put(path, options)
        request(:put, path, options)
      end

      def delete(path, options = {})
        request(:delete, path, options)
      end

      # Returns a faraday response object
      def request(method, path, options)
        # look for any string in the path matching :key. Replace it with the value and remove it from the options hash
        options.each { |k, v| options.delete(k) if path.sub! ":#{k}", v }
        @connection.send(method) do |request|
          request.url path
          if [:post, :put, :delete].include? method
            # if one of these types, use the remaining options hash as the body
            request.body = MultiJson.encode(options) unless options.empty?
          end
        end
      end
    end
  end
end
