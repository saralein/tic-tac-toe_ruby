require_relative './mocks/mock_board.rb'
require_relative '../lib/validators/player_validator.rb'
require_relative '../lib/scripts/game_script.rb'

describe PlayerValidator do
  let(:board) { MockBoard.new }
  let(:colorizer) { MockColorizer.new }
  let(:game_script) { GameScript.new(colorizer) }
  let(:validator) { PlayerValidator.new(board, game_script) }
  describe 'convert_move' do
    it 'does not raises an error if move can be converted to integer' do
      expect{ validator.convert_move('5') }.not_to raise_error
    end

    it 'raises an error if move can be converted to integer' do
      expect{ validator.convert_move('a') }.to raise_error(game_script.errors[:invalid_spot])
    end
  end

  describe 'check_range' do
    it 'raises an error if move is not in range' do
      expect{ validator.check_range(-1) }.to raise_error(game_script.errors[:out_of_range])
      expect{ validator.check_range(10) }.to raise_error(game_script.errors[:out_of_range])
    end
  end

  describe 'check_spot' do
    it 'raises an error if spot is taken' do
      board.set_grid(['-', 'O', 'X', 'O', 'X', 'O', 'X', '-', 'X'])
      expect{ validator.check_spot(2) }.to raise_error(game_script.errors[:spot_taken])
    end
  end
end
