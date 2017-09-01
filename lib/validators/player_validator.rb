class PlayerValidator
  def initialize(board, script)
    @board = board
    @script = script
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
      raise @script.errors[:invalid_spot]
    end

    return move
  end

  def check_range(move)
    length = @board.size * @board.size
    range = (0...length).to_a

    unless(range.include? move)
      raise @script.errors[:out_of_range]
    end
  end

  def check_spot(move)
    if (@board.grid[move] != @board.empty_char)
      raise @script.errors[:spot_taken]
    else
    end
  end
end
