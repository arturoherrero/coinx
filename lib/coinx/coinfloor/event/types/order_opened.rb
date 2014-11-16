require_relative 'base_event'

class OrderOpened < BaseEvent
  def execute
    message = JSON.parse(@message)
    puts "ORDER OPENED ----- PRICE: #{message['price']} ----- QUANTITY: #{message['quantity']}"
  end
end