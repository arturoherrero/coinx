require 'coinx/coinfloor/event/types/welcome'

RSpec.describe Welcome do
  it 'returns event name' do
    expect(Welcome.name).to eq('welcome')
  end
end
