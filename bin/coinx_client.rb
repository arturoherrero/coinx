require_relative '../lib/coinx/coinfloor/coinfloor_client'
require_relative '../lib/coinx/coinfloor/event/types/order_book'
require_relative '../lib/coinx/coinfloor/event/types/order_opened'
require_relative '../lib/coinx/coinfloor/event/types/order_closed'

class CoinXClient
  def initialize
    client = CoinfloorClient.new
    client.on(OrderBook   => order_book)
    client.on(OrderOpened => lambda { |event| order_changed(ORDER_OPENED, event) })
    client.on(OrderClosed => lambda { |event| order_changed(ORDER_CLOSED, event) })
    client.run
  end

  private

  ORDER_OPENED = 'OPENED'
  ORDER_CLOSED = 'CLOSED'

  def order_book
    puts 'ORDER BOOK RETRIEVED...'
  end

  def order_changed(type, event)
    puts "ORDER #{type} - PRICE: #{event['price']} - QUANTITY: #{event['quantity']}"
  end
end
