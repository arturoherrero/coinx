require_relative 'base_event'

class KeepAlive < BaseEvent
  def execute
    # log keep alive response
  end

  def self.name
    'unknown method'
  end
end