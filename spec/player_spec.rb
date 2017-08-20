require_relative '../lib/players/player.rb'
require_relative '../lib/players/ai.rb'
require_relative '../lib/players/human.rb'
require_relative '../lib/board/board_checker.rb'

describe Player do
  let(:checker) { BoardChecker.new(3, '-') }
  let(:board) { Board.new(3, '-')}
  let(:user_interface) { UserInterface.new(board, 'X', 'O') }
  let(:ai) { AI.new(checker, 'O', 'X') }
  let(:ai_player) { Player.new(ai, 'O', user_interface) }
  let(:ai_move) { "\nThe computer picks spot 1." }
  let(:empty_board) { ['-', '-', '-', '-', '-', '-', '-', '-', '-'] }

  describe 'get_move' do
    it 'displays ui message for player' do
      expect(STDOUT).to receive(:puts).with(ai_move)
      ai_player.get_move(empty_board, 9)
    end

    it 'returns a move for the player' do
      allow(STDOUT).to receive(:puts).with(ai_move)
      expect(ai_player.get_move(empty_board, 9)).to eql(0)
    end
  end
end
