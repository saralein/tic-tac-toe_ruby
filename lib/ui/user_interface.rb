class UserInterface
  def initialize(io, board, token1, token2)
    @io = io
    @board = board
    @token1 = token1
    @token2 = token2
  end

  def welcome
    @io.display_user_message("\nWelcome to Tic Tac Toe. :D")
  end

  def display_board(grid)
    output = "\n"
    grid.each_with_index do |cell, cell_index|
      output += cell == @board.empty_char ? ' ' : cell

      if (cell_index == 0 || (cell_index + 1) % @board.size != 0)
        output += ' | '
      end

      if(cell_index != @board.size**2 - 1 && (cell_index + 1) % @board.size == 0)
        output +=  "\n- + - + -\n"
      end
    end

    @io.display_user_message(output)
  end

  def human_move
    @io.display_user_message("\nPlease enter a number between 1 - 9: ")
    @io.get_user_input
  end

  def ai_move(move)
    @io.display_user_message("\nThe computer picks spot #{move + 1}.")
  end

  def end_game(winner)
    output = "\nGame over. "

    if (winner == '')
      output += "It's a draw."
    else
      output += winner == @token1 ? 'You win!' : 'The computer wins!'
    end

    @io.display_user_message(output)
  end
end
