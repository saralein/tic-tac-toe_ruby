require_relative '../lib/ui/user_interface.rb'
require_relative '../lib/board/board.rb'
require_relative './mocks/mock_io.rb'
require_relative './mocks/mock_colorizer.rb'
require_relative '../lib/scripts/game_script.rb'

describe 'UserInterface' do
  let(:welcome) { "\nWelcome to Tic Tac Toe.\n\nTo play, pick a number between 1 - 9 to place a token on the board.\nThe first player with three in a row wins.\n\nIf you'd like to stop playing, you can enter 'exit' to stop.\n" }
  let (:empty_board) { ['-', '-', '-', '-', '-', '-', '-', '-', '-'] }
  let(:moves_taken) { ['O', 'X', '-', '-', 'O', '-', 'X', 'X', 'O'] }
  let(:header) {"     Board                Moves"}
  let(:empty_string) { "    |     |    " }
  let(:full_string) { " X  |  X  |  O " }
  let(:normal_move_string) { " 1  |  2  |  3 " }
  let(:dim_move_string) { " 1  |  2  |  3 " }
  let(:row_divider) { "--- + --- + ---" }
  let(:output) { "     Board                Moves\n\n#{empty_string}          1  |  2  |  3 \n#{row_divider}      #{row_divider}"}
  let(:ai_move) { "\nThe computer picks spot 1." }
  let(:bye_bye) { "\n\nThanks for playing.\n"}
  let(:ai_win) { "\n\nGame over. O wins!\n" }
  let(:human_win) { "\n\nGame over. X wins!\n" }
  let(:draw) { "\n\nGame over. It's a draw.\n" }
  let(:board) { MockBoard.new }
  let(:io) { MockIO.new }
  let(:colorizer) { MockColorizer.new }
  let(:script) { GameScript.new(colorizer) }
  let(:user_interface) { UserInterface.new(io, script, board, colorizer) }

  before(:each) do
    user_interface.assign_color('X')
    user_interface.assign_color('O')
  end

  describe 'welcome' do
    it 'displays welcome message and available moves' do
      user_interface.welcome
      expect(io.check_message_received).to eql(welcome)
      expect(io.check_message_calls).to eql(1)
    end
  end

  describe 'display_board' do
    it 'displays the current sized board in the terminal' do
      board.set_grid(empty_board)
      user_interface.display_board
      expect(io.check_message_received).to include(header)
      expect(io.check_message_received).to include(empty_string)
      expect(io.check_message_received).to include(normal_move_string)
      expect(io.check_message_received).to include(row_divider)
      expect(io.check_message_calls).to eql(1)
    end

    it 'displays the current size board in the terminal with moves' do
      board.set_grid(moves_taken)
      user_interface.display_board
      expect(io.check_message_received).to include(header)
      expect(io.check_message_received).to include(full_string)
      expect(io.check_message_received).to include(dim_move_string)
      expect(io.check_message_received).to include(row_divider)
      expect(io.check_message_calls).to eql(1)
    end
  end

  describe 'create_header' do
    it 'creates a header for board and moves' do
      expect(user_interface.create_header).to eql(header)
    end
  end

  describe 'create_row_piece' do
    it 'takes an empty row and formats to string representation' do
      expect(user_interface.create_row_piece(['-', '-', '-'])).to eql(empty_string)
    end

    it 'takes a partial row and formats to string reprentation' do
      expect(user_interface.create_row_piece(['-', 'X', 'O'])).to eql("    |  X  |  O ")
    end

    it 'takes a full row and formats to string reprentation' do
      expect(user_interface.create_row_piece(['X', 'X', 'O'])).to eql(full_string)
    end
  end

  describe 'create_move_piece' do
    it 'returns a formatted string of moves for a row' do
      expect(user_interface.create_move_piece(['-', '-', '-'], ['1', '2', '3'])).to eql(normal_move_string)
    end

    it 'returns a formatted string of moves for a row with spots taken' do
      expect(user_interface.create_move_piece(['O', 'X', '-'], ['1', '2', '3'])).to eql(dim_move_string)
    end
  end

  describe 'add_divider' do
    it 'returns a divider for appropriate cell indices' do
      expect(user_interface.add_divider(0)).to eql(" | ")
      expect(user_interface.add_divider(4)).to eql(" | ")
      expect(user_interface.add_divider(7)).to eql(" | ")
    end

    it 'returns empty string for other cells' do
      expect(user_interface.add_divider(2)).to eql("")
      expect(user_interface.add_divider(5)).to eql("")
      expect(user_interface.add_divider(8)).to eql("")
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
      expect(user_interface.create_row_divider).to eql(row_divider)
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

  describe 'exit_game' do
    it 'displays exit message to user' do
      user_interface.exit_game
      expect(io.check_message_received).to eql(bye_bye)
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
    before(:each) do
      colorizer.reset_calls
    end

    it 'displays correct messages when ai wins' do
      user_interface.end_game('O')
      expect(io.check_message_received).to eql(ai_win)
      expect(colorizer.get_green_calls).to eql(1)
      expect(io.check_message_calls).to eql(1)
    end

    it 'displays correct messages when human wins' do
      user_interface.end_game('X')
      expect(io.check_message_received).to eql(human_win)
      expect(colorizer.get_magenta_calls).to eql(1)
      expect(io.check_message_calls).to eql(1)
    end

    it "displays correct messages when it's a draw" do
      user_interface.end_game('')
      expect(io.check_message_received).to eql(draw)
      expect(io.check_message_calls).to eql(1)
    end
  end
end
