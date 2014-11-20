require_relative '../bitcoin_client'
require_relative 'event/event_dispatcher'
require_relative 'request/coinfloor_request'
require_relative 'sandbox/sandbox'
require_relative 'scheduler/scheduler'
require_relative 'websockets/websockets'

class CoinfloorClient < BitcoinClient
  def initialize(args)
    @events_to_subscribe = args.fetch(:events_to_subscribe) { [] }
    @sandbox             = args.fetch(:sandbox) { Sandbox.new }
    @websocket_factory   = args.fetch(:websocket_factory) { WebsocketFactory.new }
    @request             = args.fetch(:coinfloor_request) { CoinfloorRequest.new }
    @event_dispatcher    = args.fetch(:event_dispatcher) { EventDispatcher.new }
    @scheduler           = args.fetch(:scheduler) { Scheduler.new }
  end

  def run
    @sandbox.run { connect }
  end

  private

  DOMAIN = 'ws://api.coinfloor.co.uk'
  KEEP_ALIVE_PERIOD_IN_SECONDS = 45

  def connect
    @ws = @websocket_factory.create(DOMAIN)
    @ws.on(:open)    { subscribe }
    @ws.on(:message) { |event| process_event(event.data) }
    @ws.on(:error)   { puts :error }
    @ws.on(:close)   { puts :close }
    keep_alive
  end

  def process_event(event_data)
    @event_dispatcher.dispatch(event_data.downcase)
  end

  def subscribe
    @events_to_subscribe.each { |event_name| @ws.send(@request.send(event_name)) }
  end

  def keep_alive
    @scheduler.every(KEEP_ALIVE_PERIOD_IN_SECONDS, SchedulerUnits::seconds) do
      @ws.send(@request.keep_alive)
    end
  end
end
