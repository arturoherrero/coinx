require 'coinx/coinfloor/event/types/order_closed'

RSpec.describe OrderClosed do
  it 'returns event name' do
    expect(OrderClosed.name).to eq('orderclosed')
  end
end
