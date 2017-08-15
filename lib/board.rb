class Board
  attr_accessor :moves, :empty_char

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
    return  there_is_full_row ||
            there_is_full_diagonal ||
            there_is_full_column ||
            all_spots_are_taken
  end

  def all_spots_are_taken
    return @moves.flatten.select{ |spot| spot == @empty_char}.length == 0
  end

  def there_is_full_row
    for row in 0...@size
      unique_chars = @moves[row].uniq
      if (unique_chars.length == 1 and unique_chars[0] != @empty_char)
        return true
      end
    end
    return false
  end

  def there_is_full_column
    for i in 0...@size
      column = []
      for j in 0...@size
        column.push(@moves[j][i])
      end
      unique_chars = column.uniq
      if (unique_chars.length == 1 and unique_chars[0] != @empty_char)
        return true
      end
    end
    return false
  end

  def there_is_full_diagonal
    if (@moves[@size/2][@size/2] == @empty_char)
      return false
    end

    left_diagonal = []
    right_diagonal = []
    for i in 0...@size
      left_diagonal.push(@moves[i][i])
      right_diagonal.push(@moves[i][@size-1 - i])
    end
    unique_left = left_diagonal.uniq
    unique_right = right_diagonal.uniq
    return (unique_left.length == 1 and unique_left[0] != @empty_char) ||
           (unique_right.length == 1 and unique_right[0] != @empty_char)
  end
end
