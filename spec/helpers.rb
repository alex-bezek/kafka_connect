module Helpers
  def stub_client(stub_data)
    stubbed_client = Faraday.new do |builder|
      builder.response :json
      builder.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
        stub_data.each do |data|
          stub.send(data[0], (data[1])) { |_env| [data[2], data[3], data[4]] }
        end
      end
    end
    allow(Faraday).to receive(:new).and_return(stubbed_client)
  end
end
