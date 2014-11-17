require 'coinx/coinfloor/event/types/order_book'

RSpec.describe OrderBook do
  it 'returns event name' do
    expect(OrderBook.name).to eq('orders')
  end
end
