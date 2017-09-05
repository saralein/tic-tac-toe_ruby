require_relative '../lib/players/player.rb'
require_relative '../lib/players/ai.rb'
require_relative '../lib/players/human.rb'
require_relative '../lib/players/player_script.rb'
require_relative '../lib/players/validator.rb'
require_relative '../lib/board/board_checker.rb'

describe Player do
  state = Struct::State.new(false, false, false)
  let(:board) { Board.new(3, '-')}
  let(:checker) { BoardChecker.new(board) }
  let(:user_interface) { MockUserInterface.new }
  let(:validator) { Validator.new(board) }
  let(:human) { Human.new(user_interface) }
  let(:script) { PlayerScript.new('get move', 'announce move')}
  let(:player) { Player.new(script, human, 'O', user_interface, validator) }

  describe 'get_move' do
    it 'gets a move from the player, retries until valid, and returns it' do
      player.get_move(9)
      expect(user_interface.times_displayed).to eql(2)
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
