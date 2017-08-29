require_relative '../lib/players/human.rb'
require_relative '../lib/board/board.rb'
require_relative './mocks/mock_user_interface.rb'

describe Human do
  let(:board) { Board.new(3, '-') }
  let(:user_interface) { MockUserInterface.new }
  let(:human) { Human.new(board, 'X')}
  let(:ask_for_move) { 'Please enter a number between 1 - 9: ' }
  let(:announce_move_message) { "\nYou picked spot 1." }
  let(:spot_taken) { ['-', '-', 'X'] }

  describe 'get_move' do
    it 'gets a move from the player, retries until valid, and returns it' do
      human.get_move(board.grid, 9, user_interface)
      expect(user_interface.times_displayed).to eql(3)

    end
  end

  describe 'announce_move' do
    it "displays player's choice of move" do
      human.announce_move(0, user_interface)
      expect(user_interface.check_message).to eql(announce_move_message)
      expect(user_interface.times_paused).to eql(1)
    end
  end

  describe 'convert_move' do
    it 'does not raises an error if move can be converted to integer' do
      expect{ human.convert_move('5') }.not_to raise_error
    end

    it 'raises an error if move can be converted to integer' do
      expect{ human.convert_move('a') }.to raise_error('Your selection is not a valid spot.')
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
