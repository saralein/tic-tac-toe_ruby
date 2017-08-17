require_relative './winner_state.rb'

class Board
  attr_accessor :moves, :empty_char, :size, :actual_state

  def initialize(size)
    @size = size
    @empty_char = '-'
    @moves = create_new_board
    @actual_state = WinnerState.new
  end

  def create_new_board
    return Array.new(@size * @size){ @empty_char }
  end

  def display_board
    output = ''
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

  def is_game_over(moves = @moves, winner_state = @actual_state)
    return there_is_full_diagonal(moves, winner_state) ||
           there_is_full_row(moves, winner_state) ||
           there_is_full_column(moves, winner_state) ||
           is_draw(moves, winner_state)
  end

  def is_draw(moves = @moves, winner_state = @actual_state)
    no_spots_left = moves.select{ |spot| spot === @empty_char }.length == 0

    if (no_spots_left)
      winner_state.winner = '-'
      winner_state.is_won = true
    end

    return no_spots_left
  end

  def there_is_full_row(moves = @moves, winner_state = @actual_state)
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

  def there_is_full_column(moves = @moves, winner_state = @actual_state)
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

  def there_is_full_diagonal(moves = @moves, winner_state = @actual_state)
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

  def is_winner(row_array, winner_state = @actual_state)
    token = row_array[0]
    is_winner = row_array.uniq.length == 1 && token != @empty_char

    if (is_winner)
      winner_state.winner = token
      winner_state.is_won = true
    end

    return is_winner
  end
end
