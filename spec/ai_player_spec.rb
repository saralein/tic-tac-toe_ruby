require_relative '../lib/players/ai_player.rb'
require_relative '../lib/board/board.rb'
require_relative '../lib/state/turn_counter.rb'

describe AIPlayer do
  let(:board) { Board.new(3) }
  let(:empty_board) {
    [
      '-', '-', '-',
      '-', '-', '-',
      '-', '-', '-'
    ]
  }
  let(:depth_5_win) {
    [
      'X', '-', 'O',
      '-', 'X', 'O',
      '-', '-', 'X'
    ]
  }
  let(:depth_1_win) {
    [
      'X', 'O', 'X',
      'X', 'O', 'X',
      'O', '-', 'X'
    ]
  }
  let(:one_spot_left) {
    [
      'X', 'O', 'X',
      'X', 'O', 'X',
      'O', '-', 'O'
    ]
  }
  let(:full_board) {
    [
      'X', 'O', 'X',
      'X', 'O', 'X',
      'O', 'X', 'O'
    ]
  }
  let(:block_win) {
    [
      'O', 'X', '-',
      '-', 'X', '-',
      '-', '-', '-'
    ]
  }
  let(:ai_player) { AIPlayer.new(board, TurnCounter.new(3), 'O', 'X') }
  let(:infinity) { Float::INFINITY}
  let(:neg_infinity) { -Float::INFINITY}

  def set_move_pattern(pattern)
    ai_player.instance_variable_get(:@board).moves = pattern
  end

  describe 'get_move' do
    context "when it is the computer's turn" do
      it 'returns an spot which has not been taken' do
        allow(STDOUT).to receive(:puts).with("\nThe computer picks spot 1.")
        expect(ai_player.get_move).to eql(0)
      end
    end
  end

  describe 'minimax' do
    it 'returns zero when depth is zero' do
      set_move_pattern(full_board)
      expect(ai_player.minimax(board, 0, neg_infinity, infinity, true)).to eql([0, -1])
    end

    it 'returns the correct score when game is over' do
      set_move_pattern(depth_5_win)
      expect(ai_player.minimax(board, 4, neg_infinity, infinity, false)).to eql([-14, -1])
      set_move_pattern(one_spot_left)
      expect(ai_player.minimax(board, 1, neg_infinity, infinity, true)).to eql([10, 7])
    end

    it 'picks the last remaining spot and returns best score and move' do
      set_move_pattern(one_spot_left)
      expect(ai_player.minimax(board, 1, neg_infinity, infinity, false)).to eql([0, 7])
    end

    it 'picks the corner for max player when open' do
      set_move_pattern(empty_board)
      expect(ai_player.minimax(board, 9, neg_infinity, infinity, true)).to eql([0, 0])
    end

    it 'blocks a win from min player' do
      set_move_pattern(block_win)
      expect(ai_player.minimax(board, 6, neg_infinity, infinity, true)).to eql([0, 7])
    end
  end

  describe 'score' do
    it 'returns zero when there is a draw' do
      expect(ai_player.score('-', 0)).to eql(0)
    end

    it 'returns the correct score for max player based on turns taken' do
      expect(ai_player.score('O', 9)).to eql(19)
      expect(ai_player.score('O', 3)).to eql(13)
    end

    it 'returns the correct score for min player based on turns taken' do
      expect(ai_player.score('X', 9)).to eql(-19)
      expect(ai_player.score('X', 5)).to eql(-15)
    end
  end
end
