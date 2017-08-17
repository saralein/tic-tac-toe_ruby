require_relative '../lib/players/human_player.rb'
require_relative '../lib/board/board.rb'

describe HumanPlayer do
  let(:player) { HumanPlayer.new('X', Board.new(3))}
  let(:ask_for_move) { 'Please enter a number between 1 - 9: ' }

  describe 'convert_move' do
    it 'does not raises an error if move can be converted to integer' do
      expect{player.convert_move('5')}.not_to raise_error
    end

    it 'does raises an error if move can be converted to integer' do
      expect{player.convert_move('a')}.to raise_error('Your selection is not an integer.')
    end
  end

  describe 'check_range' do
    it 'does raises an error if move is not in range' do
      expect{player.check_range(-1)}.to raise_error('Your selection is not between 1 and 9.')
      expect{player.check_range(10)}.to raise_error('Your selection is not between 1 and 9.')
    end
  end

  describe 'check_spot' do
    it 'does raises an error if spot is taken' do
      board = Board.new(3)
      board.moves[2] = 'X'
      player.instance_variable_set(:@board, board)
      expect{player.check_spot(2)}.to raise_error('That spot has already been selected. Pick again.')
    end
  end
end
