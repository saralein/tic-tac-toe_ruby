require_relative '../lib/scripts/game_script.rb'

describe GameScript do
  let(:script) { GameScript.new }
  let(:token_prompt) { "\nPlease select a token for Player 1: " }
  let(:move_prompt) { ""}

  describe 'create_token_prompt' do
    it 'returns a prompt asking player to select token' do
      expect(script.create_token_prompt('Player 1')).to eql(token_prompt)
    end
  end
end
