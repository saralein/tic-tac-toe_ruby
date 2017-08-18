require_relative '../lib/board/board.rb'

describe BoardChecker do
  let (:empty_board) {
    [
      '-', '-', '-',
      '-', '-', '-',
      '-', '-', '-'
    ]
  }
  let(:size_three_moves) {
    [
      '-', '-', '-',
      '-', '-', '-',
      '-', '-', '-'
    ]
  }
  let(:size_four_moves) {
    [
      '-', '-', '-', '-',
      '-', '-', '-', '-',
      '-', '-', '-', '-',
      '-', '-', '-', '-'
    ]
  }
  let(:size_three_moves_taken) {
    [
      'O', 'X', '-',
      '-', 'O', '-',
      '-', '-', 'X'
    ]
  }
  let(:full_board) {
    [
      'X', 'O', 'X',
      'O', 'X', 'O',
      'O', 'X', 'O'
    ]
  }
  let(:complete_row) {
    [
      '-', '-', 'X',
      '-', 'O', '-',
      'X', 'X', 'X'
    ]
  }
  let(:complete_column) {
    [
      'O', 'X', 'X',
      '-', 'O', 'X',
      'O', '-', 'X'
    ]
  }
  let(:complete_left_diagonal) {
    [
      'X', 'O', '-',
      'O', 'X', '-',
      '-', 'O', 'X'
    ]
  }
  let(:complete_right_diagonal) {
    [
      '-', 'O', 'X',
      'O', 'X', '-',
      'X', 'O', '-'
    ]
  }
  let(:partial_rows) {
    [
      'X', 'X', '-',
      'O', 'O', '-',
      'X', 'O', '-'
    ]
  }
  let(:partial_columns) {
    [
      'X', 'O', 'X',
      'X', 'O', 'X',
      '-', '-', '-'
    ]
  }
  let(:partial_diagonals) {
    [
      'X', '-', 'O',
      '-', '-', '-',
      'O', '-', 'X'
    ]
  }
  let(:board) { Board.new(3)}

  def set_move_pattern(pattern)
    board.instance_variable_set(:@moves, pattern)
  end

  describe 'is_game_over' do
    it 'returns true when all spots on board are taken' do
      set_move_pattern(full_board)
      expect(board.is_game_over).to eql(true)
    end

    it 'returns true when a row is full' do
      set_move_pattern(complete_row)
      expect(board.is_game_over).to eql(true)
    end

    it 'returns true when a column is full' do
      set_move_pattern(complete_column)
      expect(board.is_game_over).to eql(true)
    end

    it 'returns true when a diagonal is full' do
      set_move_pattern(complete_left_diagonal)
      expect(board.is_game_over).to eql(true)
    end

    it 'returns false when board is empty' do
      set_move_pattern(empty_board)
      expect(board.is_game_over).to eql(false)
    end
  end

  describe 'there_is_full_row' do
    it 'returns true when a row is full' do
      set_move_pattern(complete_row)
      expect(board.there_is_full_row).to eql(true)

    end

    it 'returns false if board is empty' do
      set_move_pattern(empty_board)
      expect(board.there_is_full_row).to eql(false)
    end

    it 'returns false when no rows are full' do
      set_move_pattern(partial_rows)
      expect(board.there_is_full_row).to eql(false)
    end
  end

  describe 'there_is_full_column' do
    it 'returns true when a column is full and sets projected winner' do
      set_move_pattern(complete_column)
      expect(board.there_is_full_column).to eql(true)
    end

    it 'returns false if board is empty' do
      set_move_pattern(empty_board)
      expect(board.there_is_full_column).to eql(false)
    end

    it 'returns false when no columns are full' do
      set_move_pattern(partial_columns)
      expect(board.there_is_full_column).to eql(false)
    end
  end

  describe 'there_is_full_diagonal' do
    it 'returns true when a diagonal is full' do
      set_move_pattern(complete_left_diagonal)
      expect(board.there_is_full_diagonal).to eql(true)
      set_move_pattern(complete_right_diagonal)
      expect(board.there_is_full_diagonal).to eql(true)
    end

    it 'returns false if board is empty' do
      set_move_pattern(empty_board)
      expect(board.there_is_full_diagonal).to eql(false)
    end

    it 'returns false when no diagonals are full' do
      set_move_pattern(partial_diagonals)
      expect(board.there_is_full_diagonal).to eql(false)
    end
  end

  describe 'is_winner' do
    it 'returns true when row contains only X' do
      row = ['X', 'X', 'X']
      expect(board.is_winner(row)).to eql(true)
      expect(board.winner).to eql('X')
    end

    it 'returns false when row is not full of same token' do
      row = ['-', 'O', 'X']
      expect(board.is_winner(row)).to eql(false)
      expect(board.winner).to eql(nil)
    end

    it 'returns false when row is empty' do
      row = ['-', '-', '-']
      expect(board.is_winner(row)).to eql(false)
      expect(board.winner).to eql(nil)
    end
  end
end
