require_relative '../lib/players/player.rb'
require_relative '../lib/players/ai.rb'
require_relative '../lib/players/human.rb'
require_relative '../lib/board/board_checker.rb'

describe Player do
  state = Struct::State.new(false, false, false)
  let(:checker) { BoardChecker.new(3, '-') }
  let(:board) { Board.new(3, '-')}
  let(:user_interface) { MockUserInterface.new }
  let(:ai) { AI.new(checker, 'O', 'X') }
  let(:ai_player) { Player.new(ai, 'O', user_interface) }
  let(:ai_move) { "\nThe computer picks spot 1." }
  let(:empty_board) { ['-', '-', '-', '-', '-', '-', '-', '-', '-'] }

  describe 'get_move' do
    it 'returns a move for the player' do
      expect(ai_player.get_move(empty_board, 9)).to eql(0)
    end
  end

  describe 'wants_to_restart?' do
    it 'sets stop playing to false if move is not exit' do
      ai_player.wants_to_restart?(state, '1')
      expect(state.restart).to eql(false)
    end

    it 'sets stop plating to true if move is exit' do
      ai_player.wants_to_restart?(state, :restart)
      expect(state.restart).to eql(true)
    end
  end

  describe 'wants_to_exit?' do
    it 'sets stop playing to false if move is not exit' do
      ai_player.wants_to_exit?(state, '1')
      expect(state.stop_playing).to eql(false)
    end

    it 'sets stop plating to true if move is exit' do
      ai_player.wants_to_exit?(state, :exit)
      expect(state.stop_playing).to eql(true)
    end
  end
end
