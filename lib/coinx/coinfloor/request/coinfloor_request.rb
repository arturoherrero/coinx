require 'json'

class CoinfloorRequest
  def keep_alive 
    { method: 'KeepAlive' }.to_json 
  end
  
  def live_order_book 
    { method: 'WatchOrders', base: BASE, counter: COUNTER, watch: true }.to_json
  end
  
  private

  BASE = 63488
  COUNTER = 64032
end