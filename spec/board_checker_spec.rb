require_relative '../lib/board_checker.rb'
require_relative '../lib/winner_state.rb'

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
      'X', 'O', '-',
      'O', 'X', '-',
      '-', 'O', 'X'
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
  let(:board_checker) { BoardChecker.new(3, '-')}
  let(:winner_state) { WinnerState.new }

  describe 'is_game_over' do
    it 'returns true when all spots on board are taken' do
      expect(board_checker.is_game_over(full_board, winner_state)).to eql(true)
    end

    it 'returns true when a row is full' do
      expect(board_checker.is_game_over(complete_row, winner_state)).to eql(true)
    end

    it 'returns true when a column is full' do
      expect(board_checker.is_game_over(complete_column, winner_state)).to eql(true)
    end

    it 'returns true when a diagonal is full' do
      expect(board_checker.is_game_over(complete_left_diagonal, winner_state)).to eql(true)
    end

    it 'returns false when board is empty' do
      expect(board_checker.is_game_over(empty_board, winner_state)).to eql(false)
    end
  end

  describe 'is_draw' do
    it 'returns true is all spots are taken and sets winner' do
      expect(board_checker.is_draw(full_board, winner_state)).to eql(true)
      expect(winner_state.winner).to eql('-')
      expect(winner_state.is_won).to eql(true)
    end

    it 'returns false if board is empty' do
      expect(board_checker.is_draw(empty_board, winner_state)).to eql(false)
      expect(winner_state.winner).to eql(nil)
      expect(winner_state.is_won).to eql(false)
    end

    it 'returns false if not all spots are taken' do
      expect(board_checker.is_draw(complete_row, winner_state)).to eql(false)
      expect(winner_state.winner).to eql(nil)
      expect(winner_state.is_won).to eql(false)
    end
  end

  describe 'there_is_full_row' do
    it 'returns true when a row is full' do
      expect(board_checker.there_is_full_row(complete_row, winner_state)).to eql(true)

    end

    it 'returns false if board is empty' do
      expect(board_checker.there_is_full_row(empty_board, winner_state)).to eql(false)
    end

    it 'returns false when no rows are full' do
      expect(board_checker.there_is_full_row(partial_rows, winner_state)).to eql(false)
    end
  end

  describe 'there_is_full_column' do
    it 'returns true when a column is full and sets projected winner' do
      expect(board_checker.there_is_full_column(complete_column, winner_state)).to eql(true)
    end

    it 'returns false if board is empty' do
      expect(board_checker.there_is_full_column(empty_board, winner_state)).to eql(false)
    end

    it 'returns false when no columns are full' do
      expect(board_checker.there_is_full_column(partial_columns, winner_state)).to eql(false)
    end
  end

  describe 'there_is_full_diagonal' do
    it 'returns true when a diagonal is full' do
      expect(board_checker.there_is_full_diagonal(complete_left_diagonal, winner_state)).to eql(true)
      expect(board_checker.there_is_full_diagonal(complete_right_diagonal, winner_state)).to eql(true)
    end

    it 'returns false if board is empty' do
      expect(board_checker.there_is_full_diagonal(empty_board, winner_state)).to eql(false)
    end

    it 'returns false when no diagonals are full' do
      expect(board_checker.there_is_full_diagonal(partial_diagonals, winner_state)).to eql(false)
    end
  end

  describe 'is_winner' do
    it 'returns true when row contains only X' do
      row = ['X', 'X', 'X']
      expect(board_checker.is_winner(row, winner_state)).to eql(true)
      expect(winner_state.winner).to eql('X')
      expect(winner_state.is_won).to eql(true)
    end

    it 'returns false when row is not full of same token' do
      row = ['-', 'O', 'X']
      expect(board_checker.is_winner(row, winner_state)).to eql(false)
      expect(winner_state.winner).to eql(nil)
      expect(winner_state.is_won).to eql(false)
    end

    it 'returns false when row is empty' do
      row = ['-', '-', '-']
      expect(board_checker.is_winner(row, winner_state)).to eql(false)
      expect(winner_state.winner).to eql(nil)
      expect(winner_state.is_won).to eql(false)
    end
  end
end
