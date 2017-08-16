require_relative './board.rb'
require_relative './ai_player.rb'

class Game
  def initialize(size)
    @board = Board.new(size)
    @current_player = 'human'
    @player1 = 'human'
    @player2 = AIPlayer.new(@board)
    @total_turns = size * size
    @turns_remaining = @total_turns
  end

  def play
    is_over, winner = @board.is_game_over

    until(is_over)
      take_turn
      is_over, winner = @board.is_game_over
    end

    end_game(winner)
  end

  def prep_next_move
    if (@turns_remaining < @total_turns)
      @current_player = @current_player === 'human' ? 'computer' : 'human'
    end
  end

  def take_turn
    prep_next_move
    is_human = @current_player == 'human'
    player_move = is_human ? get_player_move : get_computer_move
    player_token = is_human ? 'X' : 'O'
    @board.add_move_to_board(player_move, player_token)
    @board.display_board
    @turns_remaining -= 1
  end

  def get_player_move
    begin
      puts'Please enter a number between 1 - 9: '
      move = Integer(gets.chomp) - 1
    rescue => error
      puts 'Your selection is not an integer.'
      retry
    end
    return move
  end

  def get_computer_move
    @board.moves.flatten.each_with_index do |spot, index|
      if (spot == @board.empty_char)
        puts "The computer picks spot #{index + 1}."
        return index
      end
    end
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
