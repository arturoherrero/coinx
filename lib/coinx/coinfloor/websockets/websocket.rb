require 'faye/websocket'
require 'json'

class Websocket < Delegator
  def initialize(args)
    super
    @ws = args.fetch(:websocket) { Faye::WebSocket::Client.new(args.fetch(:domain)) }
  end

  def __getobj__
    @ws
  end

  def __setobj__(ws)
    @ws = ws
  end

  def send(message)
    @ws.send(message.to_json)
  end
end
