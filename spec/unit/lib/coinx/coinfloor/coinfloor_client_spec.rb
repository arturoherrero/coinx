require 'coinx/coinfloor/coinfloor_client'
require 'coinx/coinfloor/coinfloor_currency'

RSpec.describe CoinfloorClient do
  let(:domain)     { 'ws://api.coinfloor.co.uk' }
  let(:sandbox)    { SandboxStub.new }
  let(:ws_factory) { double }
  let(:ws)         { double }

  it 'establish a websockets connection through a sand box' do
    expect(ws_factory).to receive(:create).with(domain) { ws }
    expect(ws).to receive(:on).with(:open)
    expect(ws).to receive(:on).with(:message)
    expect(ws).to receive(:on).with(:error)
    expect(ws).to receive(:on).with(:close)

    CoinfloorClient.new(
      sandbox: sandbox,
      websocket_factory: ws_factory
    ).run
  end

  it 'subscribes to topics of interest, once ws connection is opened' do
    XBT = CoinfloorCurrency::XBT
    GBP = CoinfloorCurrency::GBP
    live_order_book_request = { method: 'WatchOrders', base: XBT, counter: GBP, watch: true }

    ws = WSStub.new(:open)

    expect(ws_factory).to receive(:create) { ws }

    client = CoinfloorClient.new(
      currency: CoinfloorCurrency::GBP,
      sandbox: sandbox,
      websocket_factory: ws_factory
    )

    client.on(OrderBook => { })
    client.run

    expect(ws.request).to eq live_order_book_request
  end

  it('reacts to ws events, once ws connection is established and subscription completed') do
    message_content = 'This is a message'
    message = MessageEventStub.new(message_content)
    oder_book_event_received = false

    ws = WSStub.new(:message, message)
    event_factory = double

    expect(ws_factory).to receive(:create) { ws }
    expect(event_factory).to receive(:create).with(message_content) { OrderBook.new('{}') }

    client = CoinfloorClient.new(
      sandbox: sandbox,
      websocket_factory: ws_factory,
      event_factory: event_factory
    )

    client.on(OrderBook => lambda { |event| oder_book_event_received = true })
    client.run

    expect(oder_book_event_received).to eq true
  end

  it 'schedules a keep alive event, once ws connection is established' do
    keep_alive_period = 45
    keep_alive_unit = 's'

    scheduler = double

    expect(scheduler).to receive(:every).with(keep_alive_period, keep_alive_unit)

    CoinfloorClient.new(
      sandbox: sandbox,
      scheduler: scheduler
    ).run
  end

  it 'sends keep alive event through the ws connection when time runs out' do
    scheduler = SchedulerStub.new
    keep_alive_request = { method: 'KeepAlive' }

    expect(ws_factory).to receive(:create) { ws }
    expect(ws).to receive(:send).with(keep_alive_request).once
    allow(ws).to receive(:on).with(:open)
    allow(ws).to receive(:on).with(:message)
    allow(ws).to receive(:on).with(:error)
    allow(ws).to receive(:on).with(:close)

    CoinfloorClient.new(
      sandbox: sandbox,
      websocket_factory: ws_factory,
      scheduler: scheduler
    ).run
  end
end

class SandboxStub
  def run(&block)
    block.call
  end
end

class SchedulerStub
  def every(time, unit, &block)
    block.call
  end
end

class WSStub
  attr_reader :request

  def initialize(event, message = '')
    @event = event
    @message = message
    @request
  end

  def on(event, &block)
    block.call(@message) if event == @event
  end

  def send(request)
    @request = request
  end
end

class MessageEventStub
  def initialize(message)
    @message = message
  end

  def data
    @message
  end
end
