require_relative '../lib/ui/user_interface.rb'
require_relative '../lib/board/board.rb'

describe 'UserInterface' do
  let (:empty_board) {
    [
      '-', '-', '-',
      '-', '-', '-',
      '-', '-', '-'
    ]
  }
  let(:moves_taken) {
    [
      'O', 'X', '-',
      '-', 'O', '-',
      '-', '-', 'X'
    ]
  }
  let(:display_output) {
    "\n  |   |  \n- + - + -\n  |   |  \n- + - + -\n  |   |  "
  }
  let(:display_output_with_moves) {
    "\nO | X |  \n- + - + -\n  | O |  \n- + - + -\n  |   | X"
  }
  let(:user_interface) { UserInterface.new(Board.new(3), 'X', 'O') }

  describe 'display_board' do
    it 'displays the current sized board in the terminal' do
      expect(STDOUT).to receive(:puts).with(display_output)
      user_interface.display_board(empty_board)
    end

    it 'displays the current size board in the terminal with moves' do
      expect(STDOUT).to receive(:puts).with(display_output_with_moves)
      user_interface.display_board(moves_taken)
    end
  end
end
