class Board
  attr_accessor :moves, :empty_char, :size, :projected_winner

  def initialize(size)
    @size = size
    @empty_char = '-'
    @moves = create_new_board
    @projected_winner = nil
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

  def is_game_over(moves = @moves)
    is_winner = there_is_a_winner(moves)
    is_draw = there_is_a_draw(moves)

    return  is_winner || is_draw
  end

  def there_is_a_winner(moves)
    return  there_is_full_row(moves) ||
            there_is_full_diagonal(moves) ||
            there_is_full_column(moves)
  end

  def there_is_a_draw(moves = @moves)
    no_spots_left = moves.flatten.select{ |spot| spot == @empty_char}.length == 0

    if (no_spots_left)
      @projected_winner = '-'
    end

    return no_spots_left
  end

  def there_is_full_row(moves = @moves)
    for row in 0...@size
      if (there_is_unique_nonempty_char(moves[row]))
        @projected_winner = moves[row][0]
        return true
      end
    end
    return false
  end

  def there_is_full_column(moves = @moves)
    for i in 0...@size
      column = []
      for j in 0...@size
        column.push(moves[j][i])
      end
      if (there_is_unique_nonempty_char(column))
        @projected_winner = column[0]
        return true
      end
    end
    return false
  end

  def there_is_full_diagonal(moves = @moves)
    if (moves[@size/2][@size/2] == @empty_char)
      return false
    end

    left_diagonal = []
    right_diagonal = []

    for i in 0...@size
      left_diagonal.push(moves[i][i])
      right_diagonal.push(moves[i][@size-1 - i])
    end

    if (there_is_unique_nonempty_char(left_diagonal) ||
        there_is_unique_nonempty_char(right_diagonal))
      @projected_winner = moves[@size/2][@size/2]
      return true
    end

    return false
  end

  def there_is_unique_nonempty_char(row_array)
    return row_array.uniq.length == 1 && row_array[0] != @empty_char
  end
end
