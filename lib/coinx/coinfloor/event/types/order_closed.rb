require_relative 'base_event'

class OrderClosed < BaseEvent
  def execute
    message = JSON.parse(@message)
    puts "ORDER CLOSED ----- PRICE: #{message['price']} ----- QUANTITY: #{message['quantity']}"
  end
end