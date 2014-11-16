require 'spec_helper'
require_relative '../../../../lib/coinx/coinfloor/coinfloor_client'

describe CoinfloorClient do
  it 'establish a websockets connection through a sand box' do
    domain = 'ws://api.coinfloor.co.uk'

    sandbox = SandboxStub.new
    ws_factory = double('ws_factory')
    ws = double('ws')

    expect(ws_factory).to receive(:create).with(domain).once { ws }
    expect(ws).to receive(:on).with(:open).once
    expect(ws).to receive(:on).with(:message).once
    expect(ws).to receive(:on).with(:error).once
    expect(ws).to receive(:on).with(:close).once

    CoinfloorClient.new(
      sandbox: sandbox, 
      websocket_factory: ws_factory
    ).run
  end

  it 'subscribes to topics of interest, once ws connection is opened' do
    events_to_subscribe = [CoinfloorEvents::live_order_book]
    live_order_book_request = double('live_order_book_request')

    sandbox = SandboxStub.new
    ws = WSStub.new(:open)
    ws_factory = double('ws_factory')
    coinfloor_request = double('coinfloor_request')

    expect(ws_factory).to receive(:create) { ws }
    expect(coinfloor_request).to receive(:live_order_book) { live_order_book_request }

    CoinfloorClient.new(
      events_to_subscribe: events_to_subscribe,
      sandbox: sandbox, 
      websocket_factory: ws_factory,
      coinfloor_request: coinfloor_request
    ).run

    expect(ws.request).to eq(live_order_book_request)
  end

  it('reacts to ws events, once ws connection is established and subscription completed') do
    message_content = 'This is a message'
    message = MessageEventStub.new(message_content)

    sandbox = SandboxStub.new
    ws = WSStub.new(:message, message)
    ws_factory = double('ws_factory')
    event_dispatcher = double('event_dispatcher')

    expect(ws_factory).to receive(:create) { ws }
    expect(event_dispatcher).to receive(:dispatch).with(message_content.downcase)

    CoinfloorClient.new(
      sandbox: sandbox, 
      websocket_factory: ws_factory,
      event_dispatcher: event_dispatcher
    ).run
  end

  it 'schedules a keep alive event, once ws connection is established' do
    keep_alive_period = 45
    keep_alive_unit = 's'

    sandbox = SandboxStub.new
    scheduler = double('scheduler')

    expect(scheduler).to receive(:every).with(keep_alive_period, keep_alive_unit)

    CoinfloorClient.new(
      sandbox: sandbox, 
      scheduler: scheduler
    ).run
  end

  it 'sends keep alive event through the ws connection when time runs out' do
    sandbox = SandboxStub.new
    scheduler = SchedulerStub.new
    ws_factory = double('ws_factory')
    coinfloor_request = double('coinfloor_request')
    keep_alive_request = double('keep_alive_request')
    ws = double('ws')

    expect(ws_factory).to receive(:create) { ws }
    expect(coinfloor_request).to receive(:keep_alive) { keep_alive_request }
    expect(ws).to receive(:send).with(keep_alive_request).once
    allow(ws).to receive(:on).with(:open)
    allow(ws).to receive(:on).with(:message)
    allow(ws).to receive(:on).with(:error)
    allow(ws).to receive(:on).with(:close)

    CoinfloorClient.new(
      sandbox: sandbox, 
      websocket_factory: ws_factory,
      coinfloor_request: coinfloor_request,
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