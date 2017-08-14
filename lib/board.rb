class Board
  attr_accessor :moves

  def initialize(size)
    @moves
    @size = size
  end

  def create_new_board
    @moves = Array.new(@size){ Array.new(@size){'-'} }
  end

  def display_board
    output = ''
    @moves.each_with_index do |row, row_index|
      row.each_with_index do |spot, spot_index|
        output += spot == '-' ? ' ' : spot
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

  def convert_move_to_row_column(move_integer)
    row = move_integer / @size
    column = move_integer % @size
    return [row, column]
  end
end
