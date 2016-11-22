module KafkaConnect
  class BaseError < StandardError; end
  class UnprocessableEntity < BaseError; end
  class InternalServerError < BaseError; end
  class ResponseError < BaseError; end
end
