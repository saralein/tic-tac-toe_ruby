class Board
  attr_accessor :moves

  def initialize(size)
    @size = size
    @empty_char = '-'
    @moves = create_new_board
  end

  def create_new_board
    return Array.new(@size){ Array.new(@size){@empty_char} }
  end

  def display_board
    output = ''
    @moves.each_with_index do |row, row_index|
      row.each_with_index do |spot, spot_index|
        output += spot == @empty_char ? ' ' : spot
        if (spot_index != @size - 1)
          output += ' | '
        end
      end
      if (row_index != @size - 1)
        output += "\n- + - + -\n"
      end
    end
    puts output
  end

  def add_move_to_board(move_integer, player_token)
    (row, column) = convert_move_to_row_column(move_integer)
    @moves[row][column] = player_token
  end

  def convert_move_to_row_column(move_integer)
    row = move_integer / @size
    column = move_integer % @size
    return [row, column]
  end

  def is_game_over
    return all_spots_are_taken
  end

  def all_spots_are_taken
    return @moves.flatten.select{ |spot| spot == @empty_char}.length == 0
  end
end
