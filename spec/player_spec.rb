require_relative '../lib/players/player.rb'
require_relative '../lib/players/ai.rb'
require_relative '../lib/players/human.rb'
require_relative '../lib/board/board_checker.rb'

describe Player do
  let(:state) { {is_playing: true, stop_playing: false, is_won: false} }
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

  describe 'exit?' do
    it 'sets stop playing to false if move is not exit' do
      ai_player.exit?(state, '1')
      expect(state[:stop_playing]).to eql(false)
    end

    it 'sets stop plating to true if move is exit' do
      ai_player.exit?(state, :exit)
      expect(state[:stop_playing]).to eql(true)
    end
  end
end
