require_relative './board_checker.rb'

class Board < BoardChecker
  attr_accessor :moves, :empty_char, :size, :winner

  def initialize(size)
    @size = size
    @empty_char = '-'
    @moves = create_new_board
    @winner = nil
  end

  def create_new_board
    return Array.new(@size**2){ @empty_char }
  end

  def add_move_to_board(move, player_token)
    @moves[move] = player_token
  end
end
