require 'rufus-scheduler'

class Scheduler

  @seconds = 's'

  class << self
    attr_reader :seconds
  end

  def initialize
    @scheduler = Rufus::Scheduler.new
  end

  def every(time, unit, &block)
    @scheduler.every("#{time}#{unit}") { block.call }
  end
end
