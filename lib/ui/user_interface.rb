class UserInterface
  def initialize(board, token1, token2)
    @board = board
    @token1 = token1
    @token2 = token2
  end

  def welcome
    puts "\nWelcome to Tic Tac Toe. :D"
    moves = (1...10).to_a.map{ |int| String(int) }
    display_board(moves)
  end

  def display_board(moves = @board.moves)
    output = "\n"
    moves.each_with_index do |cell, cell_index|
      output += cell == @board.empty_char ? ' ' : cell

      if (cell_index == 0 || (cell_index + 1) % @board.size != 0)
        output += ' | '
      end

      if(cell_index != @board.size * @board.size - 1 && (cell_index + 1) % @board.size == 0)
        output +=  "\n- + - + -\n"
      end
    end

    puts output
  end

  def end_game(winner)
    output = "\nGame over. "

    if (winner == @board.empty_char)
      output += "It's a draw."
    else
      output += winner == @token1 ? 'You win!' : 'The computer wins!'
    end

    puts output
  end
end
