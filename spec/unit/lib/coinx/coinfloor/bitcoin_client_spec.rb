require 'coinx/bitcoin_client'

RSpec.describe BitcoinClient do

  it 'executes an event action' do
    message_received = ''
    client = BitcoinClient.new('GBP')
    client.on(EventStub => lambda { |event| message_received = event })

    client.execute(EventStub.new)

    expect(message_received).to eq ({ 'message' => 'content' })
  end
end

class EventStub

  def message
    '{"message" : "content"}'
  end
end