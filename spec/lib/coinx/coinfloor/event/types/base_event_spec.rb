require 'spec_helper'
require_relative '../../../../../../lib/coinx/coinfloor/event/types/base_event'

describe BaseEvent do
  it 'returns event name' do
    expect(BaseEvent.name).to eq('baseevent')
  end
end 