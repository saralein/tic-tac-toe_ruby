require 'pry'

class AIPlayer
  attr_accessor :board

  def initialize(board)
    @board = board
    @max_player = 'O'
    @min_player = 'X'
    @depth = board.size * board.size
  end
#board, depth, alpha, beta, player
  def minimax(moves, depth, maximizingPlayer)
    game_is_over, winner = @board.is_game_over(moves)
    token = maximizingPlayer ? @max_player : @min_player
    bestScore = maximizingPlayer ? -Float::INFINITY : Float::INFINITY
    bestMove = [-1, -1]

    if(depth == 0 || game_is_over)
      bestScore = score(winner, depth)
      return [bestScore, bestMove]
    end

    for i in 0...@board.size
      for j in 0...@board.size
        if (moves[i][j] == @board.empty_char)
          moves[i][j] = token
          score, move = minimax(moves, depth - 1, !maximizingPlayer)
          # binding.pry
          if(maximizingPlayer && bestScore < score)
            bestScore = score
            bestMove = [i, j]
          end

          if(!maximizingPlayer && bestScore > score)
            bestScore = score
            bestMove = [i, j]
          end

          moves[i][j] = '-'

        end
      end
    end

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
