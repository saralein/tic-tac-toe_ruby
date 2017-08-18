require_relative './board/board.rb'
require_relative './state/turn_counter.rb'
require_relative './players/human_player.rb'
require_relative './players/ai_player.rb'
require_relative './board/board_checker.rb'
require_relative './ui/user_interface.rb'

class Game
  def initialize(size)
    @board = Board.new(size)
    @turn_counter = TurnCounter.new(size)
    @player1 = HumanPlayer.new(@board, 'X')
    @player2 = AIPlayer.new(@board, @turn_counter, 'O', 'X')
    @user_interface = UserInterface.new(@board, @player1.token, @player2.token)
    @current_player = @player1
  end

  def play
    is_over = false

    @user_interface.welcome

    until(is_over)
      prep_turn
      take_turn
      is_over = @board.is_game_over
    end

    end_game
  end

  def take_turn
    player_move = @current_player.get_move
    player_token = @current_player.token
    @board.add_move_to_board(player_move, player_token)
    @user_interface.display_board
    @turn_counter.remaining -= 1
  end

  def prep_turn
    if (@turn_counter.remaining < @turn_counter.total)
      @current_player = @current_player === @player1 ? @player2 : @player1
    end
  end

  def end_game
    @user_interface.end_game(@board.winner)
  end
end
