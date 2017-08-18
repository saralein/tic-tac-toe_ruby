require_relative '../state/winner_state.rb'
require_relative '../board/board_checker.rb'

class AIPlayer
  attr_accessor :board, :token

  def initialize(board, board_checker, turn_counter, ai_token, human_token)
    @board = board
    @board_checker = board_checker
    @turn_counter = turn_counter
    @token = ai_token
    @max_player = @token
    @min_player = human_token
    @projected_state = WinnerState.new
  end

  def get_move
    score, move = minimax(@board.moves, @turn_counter.remaining, -Float::INFINITY, Float::INFINITY, true)
    puts "\nThe computer picks spot #{move + 1}."
    return move
  end

  def minimax(moves, depth, alpha, beta, maximizingPlayer)
    game_is_over = @board_checker.is_game_over(moves, @projected_state)
    token = maximizingPlayer ? @max_player : @min_player
    bestScore = 0
    bestMove = -1

    if(depth == 0 || game_is_over)
      bestScore = score(@projected_state.winner, depth)
      return [bestScore, bestMove]
    end

    for i in 0...moves.length
      if (moves[i] == @board.empty_char)
        moves[i] = token
        bestScore, move = minimax(moves, depth - 1, alpha, beta, !maximizingPlayer)

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

        moves[i] = '-'

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
