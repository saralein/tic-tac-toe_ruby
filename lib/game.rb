require_relative './board.rb'
require_relative './turn_counter.rb'
require_relative './human_player.rb'
require_relative './ai_player.rb'

class Game
  def initialize(size)
    @board = Board.new(size)
    @turn_counter = TurnCounter.new(size)
    @player1 = HumanPlayer.new('X')
    @player2 = AIPlayer.new(@board, @turn_counter, 'O', 'X')
    @current_player = @player1
  end

  def play
    is_over, winner = @board.is_game_over

    until(is_over)
      take_turn
      is_over, winner = @board.is_game_over
    end

    end_game(winner)
  end

  def prep_turn
    if (@turn_counter.remaining < @turn_counter.total)
      @current_player = @current_player === @player1 ? @player2 : @player1
    end
  end

  def take_turn
    prep_turn
    player_move = @current_player.get_move
    player_token = @current_player.token
    @board.add_move_to_board(player_move, player_token)
    @board.display_board
    @turn_counter.remaining -= 1
  end

  def end_game(winner)
    output = "Game over. "

    if (winner == @board.empty_char)
      output += "It's a draw."
    else
      output += winner == 'X' ? 'You win!' : 'The computer wins!'
    end

    puts output
  end
end
