class AIPlayer
  def initialize(board)
    @board = board
    @projected_winner = nil
    @depth = board.size * board.size
  end

  def minimax
    if (@depth == 0)
      return score('draw')
    end

  end

  def score(winner)
    if(winner == 'max')
     return 10 + @depth
    elsif(winner == 'min')
      return -10 - @depth
    elsif(winner == 'draw')
      return 0
    end
  end
end
