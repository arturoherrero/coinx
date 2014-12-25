require 'json'

class BitcoinClient

  def initialize(currency)
    @currency = currency
    @events   = { }
  end

  def execute(event)
    action = @events[event.class] || noop
    action.call JSON.parse(event.message)
  end

  def on(event)
    @events.merge!(event)
  end

  def run
    raise "Abstract method 'run' needs to be implemented"
  end

  def get_current_stock_price(currency)
    # TODO IMPLEMENT
  end

  def get_order_book(currency)
    # TODO IMPLEMENT
  end

  private

  def noop
    lambda { |event| }
  end
end
