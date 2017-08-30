class UserInterface
  def initialize(io, board, token1, token2)
    @io = io
    @board = board
    @token1 = token1
    @token2 = token2
    @moves = ('1'.."#{@board.size**2}")
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

  def pause(amount = 1)
    @io.pause(amount)
  end

  def display_board(grid)
    output = "\n#{create_header}\n\n"
    grid_rows = grid.each_slice(@board.size).to_a
    move_rows = @moves.each_slice(@board.size).to_a

    grid_rows.each_with_index do |row, row_index|
      grid_row = create_row_piece(row)
      move_row = create_row_piece(move_rows[row_index])

      output += combine_row_pieces(grid_row, move_row)
      unless (row_index == @board.size - 1)
        output += combine_row_pieces(create_row_divider, create_row_divider)
      end
    end

    @io.display_message(output)
  end

  def create_header
    "#{create_padding(@board.size - 1)}#{:Board}#{create_padding(@board.size * 3 + @board.size / 2)}#{:Moves}"
  end

  def create_row_piece(row)
    output = ''

    row.each_with_index do |cell, cell_index|
      output += cell == '-' ? ' ' : cell
      if (cell_index == 0 || (cell_index + 1) % @board.size != 0)
        output += " | "
      end
    end

    output
  end

  def combine_row_pieces(grid_piece, move_piece)
    "#{grid_piece}#{create_padding(@board.size * 2)}#{move_piece}\n"
  end

  def create_padding(num_times)
    output = ''
    num_times.times{ output += ' ' }
    output
  end

  def create_row_divider
    Array.new(@board.size, '-').join(' + ')
  end

  def get_input
    @io.get_input
  end

  def exit_game
    @io.display_message("\n\nThanks for playing.")
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
