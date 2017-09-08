class AI
  attr_accessor :grid, :token, :checker, :script

  def initialize(board, checker, token, min_token)
    @board = board
    @checker = checker
    @token = token
    @min_token = min_token
  end

  def get_move(message, turns_remaining)
    depth = [turns_remaining, 9].min
    minimax(depth, -Float::INFINITY, Float::INFINITY, true)[1] + 1
  end

  def minimax(depth, alpha, beta, maximizingPlayer)
    @checker.clear_winner
    bestScore = 0
    bestMove = -1

    if(depth == 0 || @checker.game_over?(depth))
      bestScore = score(@checker.winner, depth)
      return [bestScore, bestMove]
    end

    for i in 0...@board.size**2
      if (@board.grid[i] == @board.empty_char)
        @board.grid[i] = maximizingPlayer ? @token : @min_token
        bestScore, move = minimax(depth - 1, alpha, beta, !maximizingPlayer)

        if(maximizingPlayer)
          if(alpha < bestScore)
            alpha = bestScore
            bestMove = i
          end
        end

        if(!maximizingPlayer)
          if(beta > bestScore)
            beta = bestScore
            bestMove = i
          end
        end

        @board.grid[i] = '-'

        if (alpha >= beta)
          break
        end
      end
    end

    bestScore = maximizingPlayer ? alpha : beta

    [bestScore, bestMove]
  end

  def score(winner, depth)
    if(winner == @token)
     return 10 + depth
    elsif(winner == @min_token)
      return -10 - depth
    else
      return 0
    end
  end
end
