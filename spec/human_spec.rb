require_relative '../lib/players/human.rb'
require_relative '../lib/board/board.rb'
require_relative '../lib/ui/user_interface.rb'

describe Human do
  let(:board) { Board.new(3, '-') }
  let(:user_interface) { UserInterface.new(board, 'X', 'O') }
  let(:human) { Human.new(board, user_interface, 'X')}
  let(:ask_for_move) { 'Please enter a number between 1 - 9: ' }
  let(:spot_taken) { ['-', '-', 'X'] }

  describe 'convert_move' do
    it 'does not raises an error if move can be converted to integer' do
      expect{ human.convert_move('5') }.not_to raise_error
    end

    it 'raises an error if move can be converted to integer' do
      expect{ human.convert_move('a') }.to raise_error('Your selection is not an integer.')
    end
  end

  describe 'check_range' do
    it 'raises an error if move is not in range' do
      expect{ human.check_range(-1) }.to raise_error('Your selection is not between 1 and 9.')
      expect{ human.check_range(10) }.to raise_error('Your selection is not between 1 and 9.')
    end
  end

  describe 'check_spot' do
    it 'raises an error if spot is taken' do
      expect{ human.check_spot(spot_taken, 2) }.to raise_error('That spot has already been selected. Pick again.')
    end
  end
end
