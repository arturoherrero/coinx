require_relative 'websocket'

class WebsocketFactory
  def create(domain)
    Websocket.new(domain: domain)
  end
end
