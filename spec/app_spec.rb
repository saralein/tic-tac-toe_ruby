require_relative '../app.rb'
require_relative './mocks/mock_io.rb'


def restart?(state, io)
  replay = io.get_input("\n\nWould you like to replay [y/n]? ").downcase
  unless(replay.to_sym == :yes || replay.to_sym == :y)
    state.stop_playing = true
  end
end

describe 'replay?' do
  Struct.new('State', :stop_playing, :is_won, :restart)
  let(:state) { Struct::State.new(false, false, false) }
  let(:io) { MockIO.new }

  it 'sets stop playing to false if yes' do
    replay?(state, io)
    expect(state.stop_playing).to eql(false)
  end

  it 'sets stop playing to false if anything else' do
    io.set_input('no, thank you.')
    replay?(state, io)
    expect(state.stop_playing).to eql(true)
  end
end
