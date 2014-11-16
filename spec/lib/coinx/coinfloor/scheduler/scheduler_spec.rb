require 'spec_helper'
require_relative '../../../../../lib/coinx/coinfloor/scheduler/scheduler'

describe Scheduler do
  it 'schedules the execution of a code block' do
    period_in_seconds = 0.3
    sleep_interval = 0.3 + 0.1
    stub = BlockStub.new
    scheduler = Scheduler.new
    scheduler.every(period_in_seconds, SchedulerUnits::seconds) { stub.increment }
    sleep(sleep_interval)
    expect(stub.counter).to eq(1)
    sleep(sleep_interval)
    expect(stub.counter).to eq(2)
  end
end 

class BlockStub

  attr_reader :counter

  def initialize
    @counter = 0
  end

  def increment
    @counter = @counter + 1
  end
end