require 'spec_helper'
require_relative '../../../../../../lib/coinx/coinfloor/event/types/order_opened'

describe OrderOpened do
  it 'returns event name' do
    expect(OrderOpened.name).to eq('orderopened')
  end
end 