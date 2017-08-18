require_relative '../lib/board/board.rb'

describe Board do
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
  let(:full_size_three_moves) {
    [
      'X', 'O', 'X',
      'O', 'X', 'O',
      'O', 'X', 'O'
    ]
  }
  let(:row_complete_size_three_moves) {
    [
      'X', 'X', 'X',
      '-', '-', '-',
      '-', '-', '-'
    ]
  }
  let(:column_complete_size_three_moves) {
    [
      'O', 'X', 'X',
      '-', 'O', 'X',
      'O', '-', 'X'
    ]
  }
  let(:left_diagonal_complete) {
    [
      'X', 'O', '-',
      'O', 'X', '-',
      '-', 'O', 'X'
    ]
  }
  let(:right_diagonal_complete) {
    [
      'X', 'O', '-',
      'O', 'X', '-',
      '-', 'O', 'X'
    ]
  }
  let(:size_three_board) { Board.new(3)}
  let(:size_four_board) { Board.new(4) }

  describe 'create_new_board' do
    it 'creates a nested array based on board size' do
      size_three_board.create_new_board
      expect(size_three_board.moves).to eql(size_three_moves)
      size_four_board.create_new_board
      expect(size_four_board.moves).to eql(size_four_moves)
    end
  end

  describe 'add_move_to_board' do
    it 'takes row/column and adds token to moves' do
      size_three_board.moves = size_three_moves
      size_three_board.add_move_to_board(0, 'O')
      size_three_board.add_move_to_board(1, 'X')
      size_three_board.add_move_to_board(4, 'O')
      size_three_board.add_move_to_board(8, 'X')
      expect(size_three_board.moves).to eql(size_three_moves_taken)
    end
  end
end
