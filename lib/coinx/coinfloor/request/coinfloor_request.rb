require 'json'

class CoinfloorRequest
  def keep_alive
    { method: 'KeepAlive' }.to_json
  end

  def live_order_book
    { method: 'WatchOrders', base: XBT, counter: GBP, watch: true }.to_json
  end

  private

  XBT = 63488
  GBP = 64032
  EUR = 64000
  USD = 64128
  PLN = 64936
end
