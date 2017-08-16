require_relative '../lib/ai_player.rb'
require_relative '../lib/board.rb'

describe AIPlayer do
  let(:board) { Board.new(3) }
  let(:empty_board) {
    [
      ['-', '-', '-'],
      ['-', '-', '-'],
      ['-', '-', '-']
    ]
  }
  let(:depth_5_win) {
    [
      ['X', '-', 'O'],
      ['-', 'X', 'O'],
      ['-', '-', 'X']
    ]
  }
  let(:depth_1_win) {
    [
      ['X', 'O', 'X'],
      ['X', 'O', 'X'],
      ['O', '-', 'X']
    ]
  }
  let(:one_spot_left) {
    [
      ['X', 'O', 'X'],
      ['X', 'O', 'X'],
      ['O', '-', 'O']
    ]
  }
  let(:full_board) {
    [
      ['X', 'O', 'X'],
      ['X', 'O', 'X'],
      ['O', 'X', 'O']
    ]
  }
  let(:ai_player) { AIPlayer.new(board) }

  def set_depth(number)
    ai_player.instance_variable_set(:@depth, number)
  end

  describe 'minimax' do
    xit 'returns zero when depth is zero' do
      set_depth(0)
      expect(ai_player.minimax).to eql([0, [-1, -1]])
    end

    xit 'returns the correct score when game is over' do
      set_depth(5)
      expect(ai_player.minimax('X', depth_5_win)).to eql([-15, [-1, -1]])
      set_depth(1)
      expect(ai_player.minimax('O', one_spot_left)).to eql([11, [2, 1]])
    end

    xit 'picks the last remaining spot and returns best score and move' do
      expect(ai_player.minimax('X', one_spot_left, 1)).to eql([0, [2, 1]])
    end

    xit 'picks the corner for max player when open' do
      expect(ai_player.minimax('O', empty_board, 9)).to eql([0, [0,0]])
      empty_board[0][1] = 'X'
      expect(ai_player.minimax('O', empty_board, 9)).to eql([0, [0,0]])
    end
  end

  describe 'score' do
    it 'returns zero when there is a draw' do
      expect(ai_player.score('-')).to eql(0)
    end

    it 'returns the correct score for max player based on turns taken' do
      expect(ai_player.score('O')).to eql(19)
      set_depth(3)
      expect(ai_player.score('O')).to eql(13)
    end

    it 'returns the correct score for min player based on turns taken' do
      expect(ai_player.score('X')).to eql(-19)
      set_depth(5)
      expect(ai_player.score('X')).to eql(-15)
    end
  end

  describe 'convert_row_column_to_move' do
    it 'converts [0, 0] to integer 0' do
      expect(ai_player.convert_row_column_to_move([0, 0])).to eql(0)
    end
  end
end
