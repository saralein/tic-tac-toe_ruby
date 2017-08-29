class Human
  attr_reader :token

  def initialize(board, user_interface, token)
    @board = board
    @user_interface = user_interface
    @token = token
  end

  def get_move(grid, turns_remaining, user_interface)
    begin
      user_interface.display_message("\nPlease enter a number between 1 - 9: ")
      move_string = user_interface.get_input
      move = convert_move(move_string)
      check_range(move)
      check_spot(grid, move)
    rescue => error
      user_interface.display_message(error)
      retry
    end
    return move
  end

  def announce_move(move, user_interface)
    user_interface.display_message("\nYou picked spot #{move + 1}.")
    user_interface.pause
  end

  def convert_move(move_string)
    begin
      move = Integer(move_string) - 1
    rescue
      raise 'Your selection is not an integer.'
    end

    return move
  end

  def check_range(move)
    length = @board.size * @board.size
    range = (0...length).to_a

    unless(range.include? move)
      raise 'Your selection is not between 1 and 9.'
    end
  end

  def check_spot(grid, move)
    if (grid[move] != @board.empty_char)
      raise 'That spot has already been selected. Pick again.'
    else
    end
  end
end
