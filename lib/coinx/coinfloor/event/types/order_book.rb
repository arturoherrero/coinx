require_relative 'base_event'

class OrderBook < BaseEvent
  def self.name
    'orders'
  end
end