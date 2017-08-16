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
  let(:row_complete_size_three_moves) {
    [
      ['X', 'X', 'X'],
      ['-', '-', '-'],
      ['-', '-', '-']
    ]
  }
  let(:column_complete_size_three_moves) {
    [
      ['O', 'X', 'X'],
      ['-', 'O', 'X'],
      ['O', '-', 'X']
    ]
  }
  let(:left_diagonal_complete) {
    [
      ['X', 'O', '-'],
      ['O', 'X', '-'],
      ['-', 'O', 'X']
    ]
  }
  let(:right_diagonal_complete) {
    [
      ['X', 'O', '-'],
      ['O', 'X', '-'],
      ['-', 'O', 'X']
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

    it 'returns true when a row is full' do
      size_three_board.moves = row_complete_size_three_moves
      expect(size_three_board.is_game_over).to eql(true)
    end

    it 'returns true when a column is full' do
      size_three_board.moves = column_complete_size_three_moves
      expect(size_three_board.is_game_over).to eql(true)
    end

    it 'returns true when a diagonal is full' do
      size_three_board.moves = left_diagonal_complete
      expect(size_three_board.is_game_over).to eql(true)
    end

    it 'returns false otherwise' do
      size_three_board.moves = size_three_moves
      expect(size_three_board.is_game_over).to eql(false)
    end
  end

  describe 'there_is_a_draw' do
    it 'returns true is all spots are taken and sets winner' do
      size_three_board.moves = full_size_three_moves
      expect(size_three_board.there_is_a_draw).to eql(true)
      expect(size_three_board.instance_variable_get(:@projected_winner)).to eql('-')
    end

    it 'returns false is not all spots are taken' do
      size_three_board.moves = row_complete_size_three_moves
      expect(size_three_board.there_is_a_draw).to eql(false)
      expect(size_three_board.instance_variable_get(:@projected_winner)).to eql(nil)
    end
  end

  describe 'there_is_full_row' do
    it 'returns true when a row is full and sets projected winner' do
      size_three_board.moves = row_complete_size_three_moves
      expect(size_three_board.there_is_full_row).to eql(true)

    end

    it 'returns false when no rows are full' do
      size_three_board.moves = full_size_three_moves
      expect(size_three_board.there_is_full_row).to eql(false)
      size_three_board.moves = size_three_moves
      expect(size_three_board.there_is_full_row).to eql(false)
      expect(size_three_board.instance_variable_get(:@projected_winner)).to eql(nil)
    end
  end

  describe 'there_is_full_column' do
    it 'returns true when a column is full and sets projected winner' do
      size_three_board.moves = column_complete_size_three_moves
      expect(size_three_board.there_is_full_column).to eql(true)
      expect(size_three_board.instance_variable_get(:@projected_winner)).to eql('X')
    end

    it 'returns false when no columns are full' do
      size_three_board.moves = full_size_three_moves
      expect(size_three_board.there_is_full_column).to eql(false)
      expect(size_three_board.instance_variable_get(:@projected_winner)).to eql(nil)
    end
  end

  describe 'there_is_full_diagonal' do
    it 'returns true when a diagonal is full' do
      size_three_board.moves = left_diagonal_complete
      expect(size_three_board.there_is_full_diagonal).to eql(true)
      size_three_board.moves = right_diagonal_complete
      expect(size_three_board.there_is_full_diagonal).to eql(true)
    end

    it 'returns false when no diagonals are full' do
      size_three_board.moves = full_size_three_moves
      expect(size_three_board.there_is_full_diagonal).to eql(false)
    end
  end

  describe 'there_is_unique_nonempty_char' do
    it 'returns true when row contains only X' do
      X_row = ['X', 'X', 'X']
      expect(size_three_board.there_is_unique_nonempty_char(X_row)).to eql(true)
    end

    it 'returns false when row is not full of same token' do
      row = ['-', 'O', 'X']
      expect(size_three_board.there_is_unique_nonempty_char(row)).to eql(false)
    end
  end
end
