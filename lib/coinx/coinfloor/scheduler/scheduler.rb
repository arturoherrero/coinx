require 'rufus-scheduler'
require_relative 'scheduler_units'

class Scheduler
  def initialize
    @scheduler = Rufus::Scheduler.new
  end

  def every(time, unit, &block)
    @scheduler.every("#{time}#{unit}") { block.call }
  end
end
