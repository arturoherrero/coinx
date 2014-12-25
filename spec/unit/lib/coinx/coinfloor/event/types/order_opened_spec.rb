require 'coinx/coinfloor/event/types/order_opened'

RSpec.describe OrderOpened do
  it 'returns event name' do
    expect(OrderOpened.name).to eq('orderopened')
  end
end
