require 'faye/websocket'

class WebsocketFactory
  def create(domain)
    Faye::WebSocket::Client.new(domain)
  end
end