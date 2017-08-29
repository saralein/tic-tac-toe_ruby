require_relative '../lib/ui/user_interface.rb'
require_relative '../lib/board/board.rb'
require_relative './mocks/mock_io.rb'

describe 'UserInterface' do
  let (:empty_board) { ['-', '-', '-', '-', '-', '-', '-', '-', '-'] }
  let(:moves_taken) { ['O', 'X', '-', '-', 'O', '-', '-', '-', 'X'] }
  let(:welcome) { "\nWelcome to Tic Tac Toe. :D" }
  let(:output) { "\n  Board          Moves\n\n  |   |        1 | 2 | 3\n- + - + -      - + - + -\n  |   |        4 | 5 | 6\n- + - + -      - + - + -\n  |   |        7 | 8 | 9\n" }
  let(:output_with_moves) { "\n  Board          Moves\n\nO | X |        1 | 2 | 3\n- + - + -      - + - + -\n  | O |        4 | 5 | 6\n- + - + -      - + - + -\n  |   | X      7 | 8 | 9\n" }
  let(:empty_string) { '  |   |  ' }
  let(:full_string) { 'X | X | O' }
  let(:ai_move) { "\nThe computer picks spot 1." }
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
      expect(io.check_message_calls).to eql(2)
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


  describe 'create_header' do
    it 'creates a header for board and moves' do
      expect(user_interface.create_header).to eql('  Board          Moves')
    end
  end

  describe 'create_row_piece' do
    it 'takes an empty row and formats to string representation' do
      expect(user_interface.create_row_piece(['-', '-', '-'])).to eql(empty_string)
    end

    it 'takes a partial row and formats to string reprentation' do
      expect(user_interface.create_row_piece(['-', 'X', 'O'])).to eql('  | X | O')
    end

    it 'takes a full row and formats to string reprentation' do
      expect(user_interface.create_row_piece(['X', 'X', 'O'])).to eql(full_string)
    end
  end

  describe 'combine_row_pieces' do
    it 'takes two empty row strings and combines them with space between' do
      expect(user_interface.combine_row_pieces(empty_string, empty_string)).to eql("#{empty_string}      #{empty_string}\n")
    end

    it 'takes two row strings and combines them with space between' do
      expect(user_interface.combine_row_pieces(full_string, full_string)).to eql("#{full_string}      #{full_string}\n")
    end
  end

  describe 'create_row_divider' do
    it 'returns a row divider of board size long' do
      expect(user_interface.create_row_divider).to eql('- + - + -')
    end
  end

  describe 'create padding' do
    it 'returns an empty string given 0' do
      expect(user_interface.create_padding(0)).to eql('')
    end

    it 'returns a space given 1' do
      expect(user_interface.create_padding(1)).to eql(' ')
    end

    it 'returns series of six spaces given 6' do
      expect(user_interface.create_padding(6)).to eql('      ')
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
