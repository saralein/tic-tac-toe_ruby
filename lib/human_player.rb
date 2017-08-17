class HumanPlayer
  attr_accessor :token

  def initialize(board, token)
    @board = board
    @token = token
  end

  def get_move
    begin
      puts'Please enter a number between 1 - 9: '
      move_string = gets.chomp
      move = convert_move(move_string)
      check_range(move)
      check_spot(move)
    rescue => error
      puts error
      retry
    end
    return move
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

  def check_spot(move)
    if (@board.moves[move] != '-')
      raise 'That spot has already been selected. Pick again.'
    else
    end
  end
end
