class Game
  def initialize(state, board, checker, player1, player2)
    @state = state
    @board = board
    @checker = checker
    @current_player, @other_player = player1, player2
    @turns_remaining = @board.size**2
  end

  def play
    until(@state[:is_won] || @state[:stop_playing])
      take_turn
      @state[:is_won] = @checker.game_over?(@turns_remaining)
    end

    if(@state[:is_won])
      end_game
    end
  end

  def take_turn
    @current_player.take_turn(@state, @board, @turns_remaining)
    @turns_remaining -= 1
    @current_player, @other_player = @other_player, @current_player
  end

  def end_game
    @current_player.end_game(@checker.winner)
  end
end
