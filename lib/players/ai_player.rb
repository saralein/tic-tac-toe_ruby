class AIPlayer
  attr_accessor :grid, :token

  def initialize(checker, token, min_token)
    @checker = checker
    @token = token
    @min_token = min_token
  end

  def get_move(grid, turns_remaining)
    move = minimax(grid, turns_remaining, -Float::INFINITY, Float::INFINITY, true)[1]
    return move
  end

  def minimax(grid, depth, alpha, beta, maximizingPlayer)
    bestScore = 0
    bestMove = -1

    if(depth == 0 || @checker.game_over?(grid,depth))
      bestScore = score(@checker.winner, depth)
      return [bestScore, bestMove]
    end

    for i in 0...grid.length
      if (grid[i] == @checker.empty_char)
        grid[i] = maximizingPlayer ? @token : @min_token
        bestScore, move = minimax(grid, depth - 1, alpha, beta, !maximizingPlayer)

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

        grid[i] = '-'

        if (alpha >= beta)
          break
        end
      end
    end

    bestScore = maximizingPlayer ? alpha : beta

    return [bestScore, bestMove]
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
