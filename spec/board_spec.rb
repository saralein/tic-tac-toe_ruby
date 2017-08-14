require_relative '../lib/board.rb'

describe Board do
  let(:size_three_board) { [
    ['-', '-', '-'],
    ['-', '-', '-'],
    ['-', '-', '-']
  ] }
  let(:size_four_board) { [
    ['-', '-', '-', '-'],
    ['-', '-', '-', '-'],
    ['-', '-', '-', '-'],
    ['-', '-', '-', '-']
  ] }
  let(:board) { Board.new }

  describe 'createNewBoard' do
    it 'creates a nested array based on board size' do
      board.createNewBoard(3)
      expect(board.board).to eql(size_three_board)
      board.createNewBoard(4)
      expect(board.board).to eql(size_four_board)
    end
  end
end
