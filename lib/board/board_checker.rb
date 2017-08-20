class BoardChecker
  attr_reader :empty_char, :winner
  def initialize(size, empty_char)
    @size = size
    @empty_char = empty_char
    @winner = ''
  end

  def game_over?(grid, turns_remaining)
    return winner?(grid) || draw?(turns_remaining)
  end

  def winner?(grid)
    rows = get_rows(grid)
    patterns = rows.push(*get_columns(rows), *get_diagonals(rows))

    winner = get_winner(patterns)
    set_winner(winner)

    return winner != ''
  end

  def draw?(turns_remaining)
    turns_remaining == 0
  end

  def get_rows(grid)
    grid.each_slice(@size).to_a
  end

  def get_columns(rows)
    rows.transpose
  end

  def get_diagonals(rows)
    [] << rows.each_with_index.map { |row, i| row[i]} <<
          rows.each_with_index.map { |row, i| row[(@size - 1) - i]}
  end

  def get_winner(patterns)
    winning_pattern = patterns.each.select { |pattern| pattern.uniq.length == 1 && pattern[0] != @empty_char }.flatten

    return winning_pattern.length == 0 ? '' : winning_pattern[0]
  end

  def set_winner(winner)
    @winner = winner
  end
end
