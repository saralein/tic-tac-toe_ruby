require 'pry'

class AIPlayer
  attr_accessor :board

  def initialize(board)
    @board = board
    @max_player = 'O'
    @min_player = 'X'
    @depth = board.size * board.size
  end

  def minimax(player = @max_player, moves = @board.moves, depth = @depth)
    other_player = player === @max_player ? @min_player : @max_player
    game_is_over, winner = @board.is_game_over(moves)
    bestScore = player == @max_player ? -Float::INFINITY : Float::INFINITY
    bestMove = [-1, -1]

    if(depth == 0 || game_is_over)
      bestScore = score(winner)
      return [bestScore, bestMove]
    end

    for i in 0...@board.size
      for j in 0...@board.size
        if (moves[i][j] == @board.empty_char)
          moves[i][j] = player
          score, move = minimax(other_player, moves, depth - 1)
          # binding.pry
          if(player == @min_player && bestScore > score)
            bestScore = score
            bestMove = [i, j]
          end

          if(player == @max_player && bestScore < score)
            bestScore = score
            bestMove = [i, j]
          end

          moves[i][j] = '-'

        end
      end
    end

    return [bestScore, bestMove]
  end

  def score(winner)
    if(winner == @max_player)
     return 10 + @depth
    elsif(winner == @min_player)
      return -10 - @depth
    else
      return 0
    end
  end

  def convert_row_column_to_move(move_array)
    i, j = move_array
    return i + j
  end
end
