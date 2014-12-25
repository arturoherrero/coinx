require 'coinx/coinfloor/event/types/keep_alive'

RSpec.describe KeepAlive do
  it 'returns event name' do
    expect(KeepAlive.name).to eq('unknown method')
  end
end
