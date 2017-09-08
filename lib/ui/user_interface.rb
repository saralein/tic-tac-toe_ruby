class UserInterface
  def initialize(io, script, board, colorizer)
    @io = io
    @script = script
    @board = board
    @colorizer = colorizer
    @colors = {}
  end

  def welcome
    clear
    display_message(@script.welcome)
    pause(4)
    clear
  end

  def clear
    @io.clear
  end

  def assign_color(token)
    color = :magenta

    unless(@colors.keys.length == 0)
      color = :green
    end

    unless(@colors.keys.include?(token))
      @colors[token] = color
    end
  end

  def display_message(message)
    @io.display_message(message)
  end

  def pause(amount = 1)
    @io.pause(amount)
  end

  def display_board
    grid = @board.grid
    output = "\n#{create_header}\n\n"
    grid_rows = grid.each_slice(@board.size).to_a
    moves = ("1".."#{@board.size**2}")
    move_rows = moves.each_slice(@board.size).to_a

    grid_rows.each_with_index do |row, row_index|
      grid_row = create_row_piece(row)
      move_row = create_move_piece(row, move_rows[row_index])

      output += combine_row_pieces(grid_row, move_row)
      unless (row_index == @board.size - 1)
        output += combine_row_pieces(create_row_divider, create_row_divider)
      end
    end

    clear
    display_message(output)
  end

  def create_header
    "#{@colorizer.blue(:Board.to_s.center(@board.size**2 + @board.size + 3))}#{create_padding(@board.size * 4 - @board.size / 2)}#{@colorizer.blue(:Moves.to_s)}"
  end

  def create_row_piece(row)
    output = ''

    row.each_with_index do |cell, cell_index|
      output += cell == '-' ? '   ' : "#{@colorizer.method(@colors[cell]).call(cell.center(3))}"
      output += add_divider(cell_index)
    end

    output
  end

  def create_move_piece(row, move_row)
    output = ''

    move_row.each_with_index do |cell, cell_index|
      display_cell = "#{cell.center(3)}"

      unless(row[cell_index] == @board.empty_char)
        display_cell = @colorizer.dim(display_cell)
      end

      output += display_cell
      output += add_divider(cell_index)
    end

    output
  end

  def add_divider(cell_index)
    output = ''

    if (cell_index == 0 || (cell_index + 1) % @board.size != 0)
      output += @colorizer.yellow(" | ")
    end

    output
  end

  def combine_row_pieces(grid_piece, move_piece)
    "#{grid_piece}#{create_padding(@board.size * 2)}#{move_piece}\n"
  end

  def create_padding(num_times)
    output = ''
    num_times.times{ output += ' ' }
    output
  end

  def create_row_divider
    @colorizer.yellow(Array.new(@board.size, '---').join(' + '))
  end

  def get_input(message)
    input = @io.get_input(message)
    clear
    input
  end

  def exit_game
    @io.display_message(@script.game_end)
  end

  def end_game(winner)
    output = @script.game_over

    if (winner == '')
      output += @script.draw
    else
      output += "#{@colorizer.method(@colors[winner]).call(winner)} wins!\n"
    end

    display_message(output)
  end
end
