require 'spec_helper'
require_relative '../../../../../../lib/coinx/coinfloor/event/types/order_book'

describe OrderBook do
  it 'returns event name' do
    expect(OrderBook.name).to eq('orders')
  end
end 