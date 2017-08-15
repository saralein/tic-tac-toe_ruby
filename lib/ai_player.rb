class AIPlayer
  def initialize(board)
    @board = board
    @projected_winner = nil
    @depth = board.size * board.size
  end

  def score
    if(@projected_winner == 'max')
     return 10 + @depth
    elsif(@projected_winner == 'min')
      return -10 - @depth
    elsif(@projected_winner == 'draw')
      return 0
    end
  end
end
