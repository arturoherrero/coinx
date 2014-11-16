require 'eventmachine'

class Sandbox
  def run(&block)
    EM.run { block.call }
  end
end