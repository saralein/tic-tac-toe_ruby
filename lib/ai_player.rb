class AIPlayer
  attr_accessor :board, :token

  def initialize(board, turn_counter, ai_token, human_token)
    @board = board
    @turn_counter = turn_counter
    @token = ai_token
    @max_player = @token
    @min_player = human_token
  end

  def get_move
    score, row_column = minimax(@board.moves, @turn_counter.remaining, -Float::INFINITY, Float::INFINITY, true)
    move = convert_row_column_to_move(row_column)
    puts "The computer picks spot #{move + 1}."
    return move
  end

  def minimax(moves, depth, alpha, beta, maximizingPlayer)
    game_is_over, winner = @board.is_game_over(moves)
    token = maximizingPlayer ? @max_player : @min_player
    bestScore = 0
    bestMove = [-1, -1]

    if(depth == 0 || game_is_over)
      bestScore = score(winner, depth)
      return [bestScore, bestMove]
    end

    for i in 0...@board.size
      for j in 0...@board.size
        if (moves[i][j] == @board.empty_char)
          moves[i][j] = token
          bestScore, move = minimax(moves, depth - 1, alpha, beta, !maximizingPlayer)

          if(maximizingPlayer)
            if(alpha < bestScore)
              alpha = bestScore
              bestMove = [i, j]
            end
          end

          if(!maximizingPlayer)
            if(beta > bestScore)
              beta = bestScore
              bestMove = [i, j]
            end
          end

          moves[i][j] = '-'

          if (alpha >= beta)
            break
          end
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

  def convert_row_column_to_move(move_array)
    i, j = move_array
    return i * @board.size + j
  end
end
