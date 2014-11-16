class CoinfloorEvents 
  @live_order_book = :live_order_book

  class << self
    attr_reader :live_order_book
  end
end