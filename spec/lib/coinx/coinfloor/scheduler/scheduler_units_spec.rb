require 'coinx/coinfloor/scheduler/scheduler_units'

RSpec.describe SchedulerUnits do
  it 'defines seconds unit' do
    expect(SchedulerUnits::seconds).to eq('s')
  end
end
