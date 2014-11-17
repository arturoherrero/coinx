require 'coinx/coinfloor/event/event_factory'

RSpec.describe EventFactory do

  before(:each) do
    @event_factory = EventFactory.new
  end

  it 'creates welcome event' do
    message = 'welcome'
    event = Welcome.new(message)
    expect(event).to be_instance_of(Welcome)
    expect(@event_factory.create(message) == event).to be_truthy
  end

  it 'creates order book event' do
    message = 'orders'
    event = OrderBook.new(message)
    expect(event).to be_instance_of(OrderBook)
    expect(@event_factory.create(message) == event).to be_truthy
  end

  it 'creates order opened event' do
    message = 'orderopened'
    event = OrderOpened.new(message)
    expect(event).to be_instance_of(OrderOpened)
    expect(@event_factory.create(message) == event).to be_truthy
  end

  it 'creates order closed event' do
    message = 'orderclosed'
    event = OrderClosed.new(message)
    expect(event).to be_instance_of(OrderClosed)
    expect(@event_factory.create(message) == event).to be_truthy
  end

  it 'creates keep alive event' do
    message = 'unknown method'
    event = KeepAlive.new(message)
    expect(event).to be_instance_of(KeepAlive)
    expect(@event_factory.create(message) == event).to be_truthy
  end
end
