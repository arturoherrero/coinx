require 'coinx/coinfloor/event/event_factory'

RSpec.describe EventFactory do
  subject(:event_factory) { EventFactory.new }

  it 'creates welcome event' do
    message = 'Welcome'
    event = Welcome.new(message)
    expect(event_factory.create(message)).to eq event
  end

  it 'creates order book event' do
    message = 'orders'
    event = OrderBook.new(message)
    expect(event_factory.create(message)).to eq event
  end

  it 'creates order opened event' do
    message = 'orderopened'
    event = OrderOpened.new(message)
    expect(event_factory.create(message)).to eq event
  end

  it 'creates order closed event' do
    message = 'orderclosed'
    event = OrderClosed.new(message)
    expect(event_factory.create(message)).to eq event
  end

  it 'creates keep alive event' do
    message = 'unknown method'
    event = KeepAlive.new(message)
    expect(event_factory.create(message)).to eq event
  end
end
