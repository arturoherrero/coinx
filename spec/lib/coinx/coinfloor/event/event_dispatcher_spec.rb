require 'coinx/coinfloor/event/event_dispatcher'

RSpec.describe EventDispatcher do
  before(:each) do
    @event_factory = double('event_factory')
    @event_dispatcher = EventDispatcher.new(event_factory: @event_factory)
  end

  it 'dispatches an event' do
    message = 'welcome'
    event = double('event')
    expect(event).to receive(:execute)
    expect(@event_factory).to receive(:create).with(message) { event }

    @event_dispatcher.dispatch(message)
  end
end
