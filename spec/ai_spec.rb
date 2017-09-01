require_relative '../lib/players/ai.rb'
require_relative '../lib/board/board_checker.rb'
require_relative '../lib/ui/user_interface.rb'
require_relative './mocks/mock_user_interface.rb'
require_relative './mocks/mock_board.rb'

describe AI do
  let(:board) { MockBoard.new }
  let(:checker) { BoardChecker.new(board) }
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
  let(:ui) { MockUserInterface.new}
  let(:ai) { AI.new(board, checker, 'O', 'X') }
  let(:infinity) { Float::INFINITY}
  let(:neg_infinity) { -Float::INFINITY}

  def get_scores(depth)
    @scores_above_zero = true

    def create_permutations(depth)
      for i in 0...9
        if(board.grid[i] == '-')
          board.grid[i] = 'X'
          bestScore, bestMove = ai.minimax(depth - 1, neg_infinity, infinity, true)
          board.grid[bestMove] = 'O'

          if(depth - 1 > 0)
            create_permutations(depth - 2)
          elsif(depth == 0 || checker.game_over?(depth - 1))
            if (bestScore < 0)
              @scores_above_zero = false
            end
          end

          board.grid[bestMove] = '-'
          board.grid[i] = '-'
        end
      end
    end

    create_permutations(depth)

    return @scores_above_zero
  end

  describe 'get_move' do
    context "when it is the computer's turn" do
      it 'returns an spot which has not been taken' do
        expect(ai.get_move('message', 9)).to eql(1)
      end
    end
  end

  describe 'minimax' do
    it 'returns zero when depth is zero' do
      board.set_grid(full_board)
      expect(ai.minimax(0, neg_infinity, infinity, true)).to eql([0, -1])
    end

    it 'returns the correct score, move when game is over' do
      board.set_grid(depth_5_win)
      expect(ai.minimax(4, neg_infinity, infinity, true)).to eql([-14, -1])
    end

    it 'picks the last remaining spot and returns best score and move' do
      board.set_grid(one_spot_left)
      expect(ai.minimax(1, neg_infinity, infinity, false)).to eql([0, 7])
    end

    it 'picks the corner for max player when open' do
      board.set_grid(empty_board)
      expect(ai.minimax(9, neg_infinity, infinity, true)).to eql([0, 0])
    end

    it 'blocks a win from min player' do
      board.set_grid(block_win)
      expect(ai.minimax(6, neg_infinity, infinity, true)).to eql([0, 7])
    end

    it 'wins or ties all 3x3 boards' do
      board.set_grid(empty_board)
      expect(get_scores(9)).to eql(true)
    end
  end

  describe 'score' do
    it 'returns zero when there is a draw' do
      expect(ai.score('-', 0)).to eql(0)
    end

    it 'returns the correct score for max player based on turns taken' do
      expect(ai.score('O', 9)).to eql(19)
      expect(ai.score('O', 3)).to eql(13)
    end

    it 'returns the correct score for min player based on turns taken' do
      expect(ai.score('X', 9)).to eql(-19)
      expect(ai.score('X', 5)).to eql(-15)
    end
  end
end
