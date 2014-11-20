require 'coinx/coinfloor/event/event_dispatcher'

RSpec.describe EventDispatcher do
  let(:message) { double }
  let(:event) { double }
  let(:event_factory) { double }
  subject(:event_dispatcher) { EventDispatcher.new(event_factory: event_factory) }

  it 'dispatches an event' do
    expect(event).to receive(:execute)
    expect(event_factory).to receive(:create).with(message) { event }

    event_dispatcher.dispatch(message)
  end
end
