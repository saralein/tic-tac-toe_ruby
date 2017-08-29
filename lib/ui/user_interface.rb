class UserInterface
  def initialize(io, board, token1, token2)
    @io = io
    @board = board
    @token1 = token1
    @token2 = token2
  end

  def welcome
    clear
    display_board(@board.grid)
    display_message("\nWelcome to Tic Tac Toe. :D")
    pause
  end

  def clear
    @io.clear
  end

  def display_message(message)
    @io.display_message(message)
  end

  def pause(amount = 2)
    @io.pause(amount)
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

    @io.display_message(output)
  end

  def get_input
    @io.get_input
  end

  def end_game(winner)
    output = "\nGame over. "

    if (winner == '')
      output += "It's a draw."
    else
      output += winner == @token1 ? 'You win!' : 'The computer wins!'
    end

    display_message(output)
  end
end
