require 'json'
require 'coinx/coinfloor/websockets/websocket'

RSpec.describe Websocket do

  let(:ws) { double }

  it 'sends a ws message converting it to json format' do
    message = { message: 'message-content' }
    websocket = Websocket.new(websocket: ws)
    expect(ws).to receive(:send).with(message.to_json)

    websocket.send(message)
  end
end
