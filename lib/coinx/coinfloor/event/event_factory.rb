require_relative 'types/welcome'
require_relative 'types/order_book'
require_relative 'types/order_opened'
require_relative 'types/order_closed'
require_relative 'types/keep_alive'

class EventFactory
  def create(message)
    event_class(message).new(message)
  end

  private 

  def event_class(message)
    events.find { |event| message.include?(event.name) }
  end

  def events
    @events ||= ObjectSpace.each_object(BaseEvent.singleton_class)
  end
end