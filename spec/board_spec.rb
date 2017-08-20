require_relative '../lib/board/board.rb'

describe Board do
  let(:empty) { ['-', '-', '-', '-', '-', '-', '-', '-', '-']}
  let(:moves_taken) { ['O', 'X', '-', '-', 'O', '-', '-', '-', 'X'] }

  before(:each) do
    @board = Board.new(3, '-')
  end

  describe 'create_grid' do
    context 'when board is instantiated' do
      it 'creates a nested array based on board size' do
        expect(@board.grid).to eql(empty)
      end
    end
  end

  describe 'add_move' do
    context 'when player takes a turn' do
      it 'takes a move and adds token to correct index in grid' do
        @board.add_move(0, 'O')
        @board.add_move(1, 'X')
        @board.add_move(4, 'O')
        @board.add_move(8, 'X')
        expect(@board.grid).to eql(moves_taken)
      end
    end
  end
end
