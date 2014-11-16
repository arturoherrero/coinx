require 'spec_helper'
require_relative '../../../../../lib/coinx/coinfloor/scheduler/scheduler_units'

describe SchedulerUnits do
  it 'defines seconds unit' do
    expect(SchedulerUnits::seconds).to eq('s')
  end
end 