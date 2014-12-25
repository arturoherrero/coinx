require_relative '../bitcoin_client'
require_relative 'coinfloor_currency'
require_relative 'event/event_factory'
require_relative 'sandbox/sandbox'
require_relative 'scheduler/scheduler'
require_relative 'websockets/websocket_factory'

class CoinfloorClient < BitcoinClient

  def initialize(args = {})
    super args.fetch(:currency) { CoinfloorCurrency::GBP }
    @sandbox             = args.fetch(:sandbox) { Sandbox.new }
    @websocket_factory   = args.fetch(:websocket_factory) { WebsocketFactory.new }
    @event_factory       = args.fetch(:event_factory) { EventFactory.new }
    @scheduler           = args.fetch(:scheduler) { Scheduler.new }
  end

  def run
    @sandbox.run { connect }
  end

  private

  COINFLOR_EVENTS = { live_order_book: [OrderBook, OrderOpened, OrderClosed] }
  DOMAIN = 'ws://api.coinfloor.co.uk'
  WATCH_ORDERS_METHOD = 'WatchOrders'
  KEEP_ALIVE_METHOD = 'KeepAlive'
  KEEP_ALIVE_PERIOD_IN_SECONDS = 45

  def connect
    @ws = @websocket_factory.create(DOMAIN)
    @ws.on(:open)    { subscribe }
    @ws.on(:message) { |event| process_event(event.data) }
    @ws.on(:error)   { puts :error }
    @ws.on(:close)   { puts :close }
    schedule_keep_alive
  end

  def subscribe
    events_to_subscribe = COINFLOR_EVENTS.select { |event_key, events| (@events.keys & events).any? }.keys
    events_to_subscribe.each { |event_name| @ws.send(self.send(event_name)) }
  end

  def process_event(event_data)
    event = @event_factory.create(event_data)
    execute event
  end

  def schedule_keep_alive
    @scheduler.every(KEEP_ALIVE_PERIOD_IN_SECONDS, Scheduler::seconds) { @ws.send(keep_alive_request) }
  end

  def keep_alive_request
    { method: KEEP_ALIVE_METHOD }
  end

  def live_order_book
    { method: WATCH_ORDERS_METHOD, base: CoinfloorCurrency::XBT, counter: @currency, watch: true }
  end
end
