require_relative 'event_factory'

class EventDispatcher
  def initialize(args = {})
    @event_factory = args.fetch(:event_factory) { EventFactory.new }
  end

  def dispatch(message)
    event = @event_factory.create(message)
    event.execute
  end
end
