class BaseEvent

  attr_reader :message

  def initialize(message)
    @message = message
  end

  def self.name
    to_s.downcase
  end

  def ==(other)
    self.message == other.message
  end
end