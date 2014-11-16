require 'spec_helper'
require_relative '../../../../../../lib/coinx/coinfloor/event/types/keep_alive'

describe KeepAlive do
  it 'returns event name' do
    expect(KeepAlive.name).to eq('unknown method')
  end
end 