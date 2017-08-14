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
  let(:display_output) {
    "  |   |  \n- + - + -\n  |   |  \n- + - + -\n  |   |  "
  }
  let(:display_output_with_moves) {
    "O | X |  \n- + - + -\n  | O |  \n- + - + -\n  |   | X"
  }
  let(:size_three_board) { Board.new(3)}
  let(:size_four_board) { Board.new(4) }

  describe 'createNewBoard' do
    it 'creates a nested array based on board size' do
      size_three_board.createNewBoard
      expect(size_three_board.moves).to eql(size_three_moves)
      size_four_board.createNewBoard
      expect(size_four_board.moves).to eql(size_four_moves)
    end
  end

  describe 'displayBoard' do
    it 'displays the current sized board in the terminal' do
      size_three_board.moves = size_three_moves
      expect(STDOUT).to receive(:puts).with(display_output)
      size_three_board.displayBoard
    end
  end

  it 'displays the current size board in the terminal with moves' do
    size_three_board.moves = size_three_moves_taken
    expect(STDOUT).to receive(:puts).with(display_output_with_moves)
    size_three_board.displayBoard
  end
end
