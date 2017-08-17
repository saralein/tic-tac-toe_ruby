class BoardChecker
  def initialize(size, empty_char)
    @size = size
    @empty_char = empty_char
  end

  def is_game_over(moves, winner_state)
    return there_is_full_diagonal(moves, winner_state) ||
           there_is_full_row(moves, winner_state) ||
           there_is_full_column(moves, winner_state) ||
           is_draw(moves, winner_state)
  end

  def is_draw(moves, winner_state)
    no_spots_left = moves.select{ |spot| spot === @empty_char }.length == 0

    if (no_spots_left)
      winner_state.winner = '-'
      winner_state.is_won = true
    end

    return no_spots_left
  end

  def there_is_full_row(moves, winner_state)
    is_won = false

    for i in 0...@size
      row_start = @size * i
      row_end = @size*(i+1)
      row = moves[row_start...row_end]
      is_won = is_winner(row, winner_state)

      if (is_won)
        return is_won
      end
    end

    return is_won
  end

  def there_is_full_column(moves, winner_state)
    is_won = false

    for i in 0...@size
      column = []
      for j in 0...@size
        column.push(moves[i + @size*j])
      end
      is_won = is_winner(column, winner_state)
      if(is_won)
        return is_won
      end
    end

    return is_won
  end

  def there_is_full_diagonal(moves, winner_state)
    left_diagonal = []
    right_diagonal = []

    for i in 0...@size
      left_diagonal.push(moves[(@size+1) * i])
      right_diagonal.push(moves[(@size+1) * i])
    end

    is_left_won = is_winner(left_diagonal, winner_state)
    is_right_won = is_winner(right_diagonal, winner_state)

    return is_left_won || is_right_won
  end

  def is_winner(row_array, winner_state)
    token = row_array[0]
    is_winner = row_array.uniq.length == 1 && token != @empty_char

    if (is_winner)
      winner_state.winner = token
      winner_state.is_won = true
    end

    return is_winner
  end
end
