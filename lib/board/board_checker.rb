class BoardChecker
  def initialize(board)
    @board = board
  end

  def is_game_over
    return there_is_full_diagonal ||
           there_is_full_row ||
           there_is_full_column ||
           is_draw
  end

  def is_draw
    no_spots_left = @board.moves.select{ |spot| spot === @board.empty_char }.length == 0

    if (no_spots_left)
      @board.winner = '-'
    end

    return no_spots_left
  end

  def there_is_full_row
    is_won = false

    for i in 0...@board.size
      row_start = @board.size * i
      row_end = @board.size*(i+1)
      row = @board.moves[row_start...row_end]
      is_won = is_winner(row)

      if (is_won)
        return is_won
      end
    end

    return is_won
  end

  def there_is_full_column
    is_won = false

    for i in 0...@board.size
      column = []
      for j in 0...@board.size
        column.push(@board.moves[i + @board.size*j])
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

    for i in 0...@board.size
      left_diagonal.push(@board.moves[(@board.size+1) * i])
      right_diagonal.push(@board.moves[(@board.size-1) * (1 + i)])
    end

    is_left_won = is_winner(left_diagonal)
    is_right_won = is_winner(right_diagonal)

    return is_left_won || is_right_won
  end

  def is_winner(row_array)
    token = row_array[0]
    is_winner = row_array.uniq.length == 1 && token != @board.empty_char

    if (is_winner)
      @board.winner = token
    end

    return is_winner
  end
end
