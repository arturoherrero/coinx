require 'coinx/coinfloor/request/coinfloor_request'

RSpec.describe CoinfloorRequest do
  subject(:coinfloor_request) { CoinfloorRequest.new }

  it 'defines coinfloor keep alive request' do
    keep_alive = { method: 'KeepAlive' }.to_json
    expect(coinfloor_request.keep_alive).to eq(keep_alive)
  end

  it 'defines coinfloor live order book request' do
    order_book = { method: 'WatchOrders', base: 63488, counter: 64032, watch: true }.to_json
    expect(coinfloor_request.live_order_book).to eq(order_book)
  end
end
