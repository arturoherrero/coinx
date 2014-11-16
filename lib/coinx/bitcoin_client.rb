class BitcoinClient
  def run
    raise "Abstract method 'run' needs to be implemented"
  end

  def get_current_stock_price(currency)
    # TODO IMPLEMENT
  end

  def get_order_book(currency)
    # TODO IMPLEMENT
  end

  def set_order_changed_callback
    # TODO IMPLEMENT
  end
end