class BoardChecker
  def is_game_over
    return there_is_full_diagonal ||
           there_is_full_row ||
           there_is_full_column ||
           is_draw
  end

  def is_draw
    no_spots_left = @moves.select{ |spot| spot === @empty_char }.length == 0

    if (no_spots_left)
      @winner = '-'
    end

    return no_spots_left
  end

  def there_is_full_row
    is_won = false

    for i in 0...@size
      row_start = @size * i
      row_end = @size*(i+1)
      row = @moves[row_start...row_end]
      is_won = is_winner(row)

      if (is_won)
        return is_won
      end
    end

    return is_won
  end

  def there_is_full_column
    is_won = false

    for i in 0...@size
      column = []
      for j in 0...@size
        column.push(@moves[i + @size*j])
      end
      is_won = is_winner(column)
      if(is_won)
        return is_won
      end
    end

    return is_won
  end

  def there_is_full_diagonal
    left_diagonal = []
    right_diagonal = []

    for i in 0...@size
      left_diagonal.push(@moves[(@size+1) * i])
      right_diagonal.push(@moves[(@size-1) * (1 + i)])
    end

    is_left_won = is_winner(left_diagonal)
    is_right_won = is_winner(right_diagonal)

    return is_left_won || is_right_won
  end

  def is_winner(row_array)
    token = row_array[0]
    is_winner = row_array.uniq.length == 1 && token != @empty_char

    if (is_winner)
      @winner = token
    end

    return is_winner
  end
end
