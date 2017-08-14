require_relative '../lib/board.rb'

describe Board do
  let(:size_three_moves) {
    [
      ['-', '-', '-'],
      ['-', '-', '-'],
      ['-', '-', '-']
    ]
  }
  let(:size_four_moves) {
    [
      ['-', '-', '-', '-'],
      ['-', '-', '-', '-'],
      ['-', '-', '-', '-'],
      ['-', '-', '-', '-']
    ]
  }
  let(:size_three_moves_taken) {
    [
      ['O', 'X', '-'],
      ['-', 'O', '-'],
      ['-', '-', 'X']
    ]
  }
  let(:full_size_three_moves) {
    [
      ['X', 'O', 'X'],
      ['O', 'X', 'O'],
      ['O', 'X', 'O']
    ]
  }
  let(:display_output) {
    "  |   |  \n- + - + -\n  |   |  \n- + - + -\n  |   |  "
  }
  let(:display_output_with_moves) {
    "O | X |  \n- + - + -\n  | O |  \n- + - + -\n  |   | X"
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

  describe 'display_board' do
    it 'displays the current sized board in the terminal' do
      size_three_board.moves = size_three_moves
      expect(STDOUT).to receive(:puts).with(display_output)
      size_three_board.display_board
    end

    it 'displays the current size board in the terminal with moves' do
      size_three_board.moves = size_three_moves_taken
      expect(STDOUT).to receive(:puts).with(display_output_with_moves)
      size_three_board.display_board
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

  describe 'convert_move_to_row_column' do
    it 'converts integer to row and column location' do
      expect(size_three_board.convert_move_to_row_column(2)).to eql([0, 2])
      expect(size_three_board.convert_move_to_row_column(4)).to eql([1, 1])
      expect(size_three_board.convert_move_to_row_column(6)).to eql([2, 0])
    end
  end

  describe 'is_game_over' do
    it 'returns true when all spots on board are taken' do
      size_three_board.moves = full_size_three_moves
      expect(size_three_board.is_game_over).to eql(true)
    end
  end

  describe 'all_spots_are_taken' do
    it 'returns true is all spots are taken' do
      size_three_board.moves = full_size_three_moves
      expect(size_three_board.all_spots_are_taken).to eql(true)
    end
  end
end
