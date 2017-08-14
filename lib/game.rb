require_relative './board.rb'

class Game
  def initialize(size)
    @board = Board.new(size)
    @current_player = 'human'
  end

  def play
    until(@board.is_game_over)
      take_turn
    end
  end

  def take_turn
    is_human = @current_player == 'human'
    player_move = is_human ? get_player_move : get_computer_move
    player_token = is_human ? 'X' : 'O'
    @board.add_move_to_board(player_move, player_token)
    @board.display_board
    @current_player = is_human ? 'computer' : 'human'
  end

  def get_player_move
    puts 'Please enter a number between 1 - 9: '
    return Integer(gets.chomp) - 1
  end

  def get_computer_move
    @board.moves.flatten.each_with_index do |spot, index|
      if (spot == @board.empty_char)
        puts "The computer picks spot #{index + 1}."
        return index
      end
    end
  end
end
