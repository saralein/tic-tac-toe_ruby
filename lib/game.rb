class Game
  def initialize(board, checker, player1, player2)
    @board = board
    @checker = checker
    @current_player, @other_player = player1, player2
    @turns_remaining = @board.size**2
    @is_won = false
  end

  def play
    trap('INT') do
      exit_game
    end

    until(@is_won)
      take_turn
      @is_won = @checker.game_over?(@board.grid, @turns_remaining)
    end

    end_game
  end

  def take_turn
    @current_player.take_turn(@board, @turns_remaining)
    @turns_remaining -= 1
    @current_player, @other_player = @other_player, @current_player
  end

  def exit_game
    @current_player.exit_game
    exit
  end

  def end_game
    @current_player.end_game(@checker.winner)
  end
end
