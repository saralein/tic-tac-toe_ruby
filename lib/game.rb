require_relative './board.rb'

class Game
  def initialize(size)
    @board = Board.new(size)
  end

  def play
    until(@board.is_game_over)
      take_turn
    end
  end

  def take_turn
    player_move = get_player_move
    @board.add_move_to_board(player_move, 'X')
    @board.display_board
  end

  def get_player_move
    puts 'Please enter a number between 1 - 9: '
    return Integer(gets.chomp) - 1
  end
end
