require_relative './board/board.rb'
require_relative './state/turn_counter.rb'
require_relative './players/human_player.rb'
require_relative './players/ai_player.rb'
require_relative './board/board_checker.rb'

class Game
  def initialize(size)
    @board = Board.new(size)
    @board_checker = BoardChecker.new(size, @board.empty_char)
    @turn_counter = TurnCounter.new(size)
    @player1 = HumanPlayer.new(@board, 'X')
    @player2 = AIPlayer.new(@board, @turn_counter, 'O', 'X')
    @current_player = @player1
  end

  def play
    is_over = false

    puts "\nWelcome to Tic Tac Toe. :D"

    until(is_over)
      prep_turn
      take_turn
      is_over = @board_checker.is_game_over(@board.moves, @board.actual_state)
    end

    end_game
  end

  def take_turn
    player_move = @current_player.get_move
    player_token = @current_player.token
    @board.add_move_to_board(player_move, player_token)
    @board.display_board
    @turn_counter.remaining -= 1
  end

  def prep_turn
    if (@turn_counter.remaining < @turn_counter.total)
      @current_player = @current_player === @player1 ? @player2 : @player1
    end
  end

  def end_game
    winner = @board.actual_state.winner
    output = "\nGame over. "

    if (winner == @board.empty_char)
      output += "It's a draw."
    else
      output += winner == @player1.token ? 'You win!' : 'The computer wins!'
    end

    puts output
  end
end
