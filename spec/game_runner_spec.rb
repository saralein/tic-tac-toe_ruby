require_relative '../lib/util/game_runner.rb'
require_relative './mocks/mock_user_interface.rb'
require_relative './mocks/mock_game.rb'

describe GameRunner do
  let(:state) { GameProgress.new }
  let(:user_interface) { MockUserInterface.new }
  let(:game) { MockGame.new(state) }
  let(:game_runner) { GameRunner.new(game, user_interface) }

  describe 'replay?' do
    it 'sets stop playing to false if yes' do
      user_interface.set_input(['YES'])
      game_runner.replay?
      expect(game.state.stop_playing).to eql(false)
    end

    it 'sets stop playing to false if anything else' do
      user_interface.set_input(['no, thank you.'])
      game_runner.replay?
      expect(game.state.stop_playing).to eql(true)
    end
  end
end
