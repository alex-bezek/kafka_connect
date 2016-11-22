require 'spec_helper'

describe KafkaConnect do
  it 'has a version number' do
    expect(KafkaConnect::VERSION).not_to be nil
  end
end
