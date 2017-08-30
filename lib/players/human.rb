class Human
  attr_reader :token

  def initialize(board, user_interface, token)
    @board = board
    @user_interface = user_interface
    @token = token
  end

  def get_move(grid, turns_remaining)
    begin
      move_string = @user_interface.human_move
      return :exit if exit?(move_string)
      move = convert_move(move_string)
      check_range(move)
      check_spot(grid, move)
    rescue => error
      puts error
      retry
    end
    return move
  end

  def exit?(move_string)
    move_string.to_sym == :exit
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
