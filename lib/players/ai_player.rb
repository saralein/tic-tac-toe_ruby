class AIPlayer
  attr_accessor :board, :token

  def initialize(board, turn_counter, user_interface, ai_token, human_token)
    @board = board
    @turn_counter = turn_counter
    @user_interface = user_interface
    @token = ai_token
    @max_player = @token
    @min_player = human_token
  end

  def get_move
    score, move = minimax(@board, @turn_counter.remaining, -Float::INFINITY, Float::INFINITY, true)
    @user_interface.ai_move(move)
    return move
  end

  def minimax(board, depth, alpha, beta, maximizingPlayer)
    game_is_over = @board.is_game_over
    bestScore = 0
    bestMove = -1

    if(depth == 0 || game_is_over)
      bestScore = score(@board.winner, depth)
      return [bestScore, bestMove]
    end

    for i in 0...@board.moves.length
      if (@board.moves[i] == @board.empty_char)
        @board.moves[i] = maximizingPlayer ? @max_player : @min_player
        bestScore, move = minimax(board, depth - 1, alpha, beta, !maximizingPlayer)

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

        @board.moves[i] = '-'

        if (alpha >= beta)
          break
        end
      end
    end

    bestScore = maximizingPlayer ? alpha : beta

    return [bestScore, bestMove]
  end

  def score(winner, depth)
    if(winner == @max_player)
     return 10 + depth
    elsif(winner == @min_player)
      return -10 - depth
    else
      return 0
    end
  end
end
