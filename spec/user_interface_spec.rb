require_relative '../lib/ui/user_interface.rb'
require_relative '../lib/board/board.rb'

describe 'UserInterface' do
  let (:empty_board) { ['-', '-', '-', '-', '-', '-', '-', '-', '-'] }
  let(:moves_taken) { ['O', 'X', '-', '-', 'O', '-', '-', '-', 'X'] }
  let(:welcome) { "\nWelcome to Tic Tac Toe. :D" }
  let(:available_moves) { "\n1 | 2 | 3\n- + - + -\n4 | 5 | 6\n- + - + -\n7 | 8 | 9" }
  let(:output) { "\n  |   |  \n- + - + -\n  |   |  \n- + - + -\n  |   |  " }
  let(:output_with_moves) { "\nO | X |  \n- + - + -\n  | O |  \n- + - + -\n  |   | X" }
  let(:ai_move) { "\nThe computer picks spot 1." }
  let(:ai_win) { "\nGame over. The computer wins!" }
  let(:human_win) { "\nGame over. You win!" }
  let(:draw) { "\nGame over. It's a draw." }
  let(:user_interface) { UserInterface.new(Board.new(3, '-'), 'X', 'O') }

  describe 'welcome' do
    it 'displays welcome message and available moves' do
      expect(STDOUT).to receive(:puts).with(welcome)
      expect(STDOUT).to receive(:puts).with(available_moves)
      user_interface.welcome
    end
  end

  describe 'display_board' do
    it 'displays the current sized board in the terminal' do
      expect(STDOUT).to receive(:puts).with(output)
      user_interface.display_board(empty_board)
    end

    it 'displays the current size board in the terminal with moves' do
      expect(STDOUT).to receive(:puts).with(output_with_moves)
      user_interface.display_board(moves_taken)
    end
  end

  describe 'ai_move' do
    it 'displays the correct ai move' do
      expect(STDOUT).to receive(:puts).with(ai_move)
      user_interface.ai_move(0)
    end
  end

  describe 'end_game' do
    it 'displays correct messages when ai wins' do
      expect(STDOUT).to receive(:puts).with(ai_win)
      user_interface.end_game('O')
    end

    it 'displays correct messages when human wins' do
      expect(STDOUT).to receive(:puts).with(human_win)
      user_interface.end_game('X')
    end

    it "displays correct messages when it's a draw" do
      expect(STDOUT).to receive(:puts).with(draw)
      user_interface.end_game('')
    end
  end
end
