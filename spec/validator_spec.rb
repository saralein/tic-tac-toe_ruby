require_relative './mocks/mock_board.rb'
require_relative '../lib/players/validator.rb'

describe Validator do
  let(:board) { MockBoard.new }
  let(:validator) { Validator.new(board) }
  describe 'convert_move' do
    it 'does not raises an error if move can be converted to integer' do
      expect{ validator.convert_move('5') }.not_to raise_error
    end

    it 'raises an error if move can be converted to integer' do
      expect{ validator.convert_move('a') }.to raise_error('Your selection is not a valid spot. Pick again: ')
    end
  end

  describe 'check_range' do
    it 'raises an error if move is not in range' do
      expect{ validator.check_range(-1) }.to raise_error('Your selection is not between 1 and 9. Pick again: ')
      expect{ validator.check_range(10) }.to raise_error('Your selection is not between 1 and 9. Pick again: ')
    end
  end

  describe 'check_spot' do
    it 'raises an error if spot is taken' do
      board.set_grid(['-', 'O', 'X', 'O', 'X', 'O', 'X', '-', 'X'])
      expect{ validator.check_spot(2) }.to raise_error('That spot has already been selected. Pick again: ')
    end
  end
end
