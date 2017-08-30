class BoardChecker
  attr_reader :empty_char, :winner
  def initialize(board)
    @board = board
    @winner = ''
  end

  def game_over?(turns_remaining)
    return winner? || draw?(turns_remaining)
  end

  def winner?
    rows = get_rows
    patterns = rows.push(*get_columns(rows), *get_diagonals(rows))

    winner = get_winner(patterns)
    set_winner(winner)

    return winner != ''
  end

  def draw?(turns_remaining)
    turns_remaining == 0
  end

  def get_rows
    @board.grid.each_slice(@board.size).to_a
  end

  def get_columns(rows)
    rows.transpose
  end

  def get_diagonals(rows)
    [] << rows.each_with_index.map { |row, i| row[i]} <<
          rows.each_with_index.map { |row, i| row[(@board.size - 1) - i]}
  end

  def get_winner(patterns)
    winning_pattern = patterns.each.select { |pattern| pattern.uniq.length == 1 && pattern[0] != @board.empty_char }.flatten

    return winning_pattern.length == 0 ? '' : winning_pattern[0]
  end

  def set_winner(winner)
    @winner = winner
  end

  def clear_winner
    @winner = ''
  end
end
