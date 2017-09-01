require_relative '../lib/players/validator.rb'

describe Validator do
  describe 'convert_move' do
    it 'does not raises an error if move can be converted to integer' do
      expect{ human.convert_move('5') }.not_to raise_error
    end

    it 'raises an error if move can be converted to integer' do
      expect{ human.convert_move('a') }.to raise_error('Your selection is not a valid spot. Pick again: ')
    end
  end

  describe 'check_range' do
    it 'raises an error if move is not in range' do
      expect{ human.check_range(-1) }.to raise_error('Your selection is not between 1 and 9. Pick again: ')
      expect{ human.check_range(10) }.to raise_error('Your selection is not between 1 and 9. Pick again: ')
    end
  end

  describe 'check_spot' do
    it 'raises an error if spot is taken' do
      expect{ human.check_spot(spot_taken, 2) }.to raise_error('That spot has already been selected. Pick again: ')
    end
  end
end
