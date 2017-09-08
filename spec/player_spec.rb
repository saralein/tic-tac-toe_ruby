require_relative '../lib/players/player.rb'
require_relative '../lib/players/ai.rb'
require_relative '../lib/players/human.rb'
require_relative '../lib/scripts/player_script.rb'
require_relative '../lib/validators/player_validator.rb'
require_relative '../lib/board/board_checker.rb'

describe Player do
  state = GameProgress.new
  let(:board) { Board.new(3, '-')}
  let(:checker) { BoardChecker.new(board) }
  let(:user_interface) { MockUserInterface.new }
  let(:validator) { PlayerValidator.new(board) }
  let(:human) { Human.new(user_interface) }
  let(:script) { PlayerScript.new('get move', 'announce move')}
  let(:player) { Player.new(script, human, 'O', user_interface, validator) }

  describe 'get_move' do
    it 'gets a move from the player, retries until valid, and returns it' do
      user_interface.set_input(['dog', '8'])
      expect(player.get_move(9)).to eql(7)
      expect(user_interface.get_display_calls).to eql(1)
    end
  end

  describe 'wants_to_restart?' do
    it 'sets stop playing to false if move is not exit' do
      player.wants_to_restart?(state, '1')
      expect(state.restart).to eql(false)
    end

    it 'sets stop plating to true if move is exit' do
      player.wants_to_restart?(state, :restart)
      expect(state.restart).to eql(true)
    end
  end

  describe 'wants_to_exit?' do
    it 'sets stop playing to false if move is not exit' do
      player.wants_to_exit?(state, '1')
      expect(state.stop_playing).to eql(false)
    end

    it 'sets stop plating to true if move is exit' do
      player.wants_to_exit?(state, :exit)
      expect(state.stop_playing).to eql(true)
    end
  end
end
