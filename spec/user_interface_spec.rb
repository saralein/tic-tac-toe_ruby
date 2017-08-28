require_relative '../lib/ui/user_interface.rb'
require_relative '../lib/board/board.rb'
require_relative './mocks/mock_io.rb'

describe 'UserInterface' do
  let (:empty_board) { ['-', '-', '-', '-', '-', '-', '-', '-', '-'] }
  let(:moves_taken) { ['O', 'X', '-', '-', 'O', '-', '-', '-', 'X'] }
  let(:welcome) { "\nWelcome to Tic Tac Toe. :D" }
  let(:available_moves) { "\n1 | 2 | 3\n- + - + -\n4 | 5 | 6\n- + - + -\n7 | 8 | 9" }
  let(:output) { "\n  |   |  \n- + - + -\n  |   |  \n- + - + -\n  |   |  " }
  let(:output_with_moves) { "\nO | X |  \n- + - + -\n  | O |  \n- + - + -\n  |   | X" }
  let(:ai_move) { "\nThe computer picks spot 1." }
  let(:bye_bye) { "\nThanks for playing."}
  let(:ai_win) { "\nGame over. The computer wins!" }
  let(:human_win) { "\nGame over. You win!" }
  let(:draw) { "\nGame over. It's a draw." }
  let(:board) { Board.new(3, '-') }
  let(:io) { MockIO.new }
  let(:user_interface) { UserInterface.new(io, board, 'X', 'O') }

  describe 'welcome' do
    it 'displays welcome message and available moves' do
      user_interface.welcome
      expect(io.check_message_received).to eql(welcome)
      expect(io.check_message_calls).to eql(1)
    end
  end

  describe 'display_board' do
    it 'displays the current sized board in the terminal' do
      user_interface.display_board(empty_board)
      expect(io.check_message_received).to eql(output)
      expect(io.check_message_calls).to eql(1)
    end

    it 'displays the current size board in the terminal with moves' do
      user_interface.display_board(moves_taken)
      expect(io.check_message_received).to eql(output_with_moves)
      expect(io.check_message_calls).to eql(1)
    end
  end

  describe 'ai_move' do
    it 'displays the correct ai move' do

      user_interface.ai_move(0)
      expect(io.check_message_received).to eql(ai_move)
      expect(io.check_message_calls).to eql(1)
    end
  end

  describe 'exit_game' do
    it 'displays exit message to user' do
      user_interface.exit_game
      expect(io.check_message_received).to eql(bye_bye)
      expect(io.check_message_calls).to eql(1)
    end
  end

  describe 'end_game' do
    it 'displays correct messages when ai wins' do
      user_interface.end_game('O')
      expect(io.check_message_received).to eql(ai_win)
      expect(io.check_message_calls).to eql(1)
    end

    it 'displays correct messages when human wins' do
      user_interface.end_game('X')
      expect(io.check_message_received).to eql(human_win)
      expect(io.check_message_calls).to eql(1)
    end

    it "displays correct messages when it's a draw" do
      user_interface.end_game('')
      expect(io.check_message_received).to eql(draw)
      expect(io.check_message_calls).to eql(1)
    end
  end
end
