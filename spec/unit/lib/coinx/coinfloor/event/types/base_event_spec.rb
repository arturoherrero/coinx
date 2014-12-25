require 'coinx/coinfloor/event/types/base_event'

RSpec.describe BaseEvent do
  it 'returns event name' do
    expect(BaseEvent.name).to eq('baseevent')
  end
end
