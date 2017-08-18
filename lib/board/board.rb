class Board
  attr_accessor :moves, :empty_char, :size, :winner

  def initialize(size)
    @size = size
    @empty_char = '-'
    @moves = create_new_board
    @winner = nil
  end

  def create_new_board
    return Array.new(@size * @size){ @empty_char }
  end

  def display_board
    output = "\n"
    @moves.each_with_index do |cell, cell_index|
      output += cell == @empty_char ? ' ' : cell

      if (cell_index == 0 || (cell_index + 1) % @size != 0)
        output += ' | '
      end

      if(cell_index != @size * @size - 1 && (cell_index + 1) % @size == 0)
        output +=  "\n- + - + -\n"
      end
    end

    puts output
  end

  def add_move_to_board(move, player_token)
    @moves[move] = player_token
  end
end
