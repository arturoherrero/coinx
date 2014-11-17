require 'coinx/coinfloor/event/coinfloor_events'

RSpec.describe CoinfloorEvents do
  it 'defines live order book event' do
    expect(CoinfloorEvents::live_order_book).to eq(:live_order_book)
  end
end
