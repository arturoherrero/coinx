require 'spec_helper'
require_relative '../../../../../../lib/coinx/coinfloor/event/types/welcome'

describe Welcome do
  it 'returns event name' do
    expect(Welcome.name).to eq('welcome')
  end
end 