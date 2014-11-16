require 'spec_helper'
require_relative '../../../../../lib/coinx/coinfloor/event/coinfloor_events'

describe CoinfloorEvents do
  it 'defines live order book event' do
    expect(CoinfloorEvents::live_order_book).to eq(:live_order_book)
  end
end 