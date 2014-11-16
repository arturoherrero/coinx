require 'spec_helper'
require_relative '../../../../../../lib/coinx/coinfloor/event/types/order_closed'

describe OrderClosed do
  it 'returns event name' do
    expect(OrderClosed.name).to eq('orderclosed')
  end
end 