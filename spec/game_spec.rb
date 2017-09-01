require_relative '../lib/game.rb'
require_relative '../lib/board/board.rb'
require_relative '../lib/board/board_checker.rb'
require_relative '../lib/players/player.rb'
require_relative '../lib/players/ai.rb'
require_relative '../lib/scripts/game_script.rb'
require_relative '../lib/scripts/player_script.rb'
require_relative '../lib/validators/player_validator.rb'
require_relative './mocks/mock_user_interface.rb'

describe 'Game' do
  let(:state) { {is_playing: true, stop_playing: false, is_won: false} }
  let(:board) { Board.new(3, '-') }
  let(:checker) { BoardChecker.new(board) }
  let(:user_interface) { MockUserInterface.new }
  let(:config) { MockConfig.new }
  let(:colorizer) { MockColorizer.new }
  let(:game_script) { GameScript.new(colorizer) }
  let(:validator) { PlayerValidator.new(board, game_script) }
  let(:ai1) { AI.new(board, checker, 'X', 'O') }
  let(:ai2) { AI.new(board, checker, 'O', 'X') }
  let(:player_script) { PlayerScript.new('get move', 'announce move')}
  let(:player1) { Player.new(player_script, ai1, 'X', user_interface, validator) }
  let(:player2) { Player.new(player_script, ai2, 'O', user_interface, validator) }
  let(:game) { Game.new(state, board, checker, player1, player2) }

  describe 'take_turn' do
    it 'decrements turns remaining' do
      allow(player1).to receive(:take_turn)
      game.take_turn
      expect(game.instance_variable_get(:@turns_remaining)).to eql(8)
    end

    it 'updates the current player' do
      allow(player1).to receive(:take_turn)
      game.take_turn
      expect(game.instance_variable_get(:@current_player)).to be(player2)
      expect(game.instance_variable_get(:@other_player)).to be(player1)
    end
  end
end
