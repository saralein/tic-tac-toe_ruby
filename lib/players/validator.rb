class Validator
  def initialize(board)
    @board = board
  end

  def validate_move(move_string)
    move = convert_move(move_string)
    check_range(move)
    check_spot(move)
    move
  end

  def convert_move(move_string)
    begin
      move = Integer(move_string) - 1
    rescue
      raise 'Your selection is not a valid spot. Pick again: '
    end

    return move
  end

  def check_range(move)
    length = @board.size * @board.size
    range = (0...length).to_a

    unless(range.include? move)
      raise 'Your selection is not between 1 and 9. Pick again: '
    end
  end

  def check_spot(move)
    if (@board.grid[move] != @board.empty_char)
      raise 'That spot has already been selected. Pick again: '
    else
    end
  end
end
