class MockBoard
  attr_accessor :size, :empty_char, :grid
  def initialize
    @size = 3
    @empty_char = '-'
    @grid = ['-', '-', '-', '-', '-', '-', '-', '-', '-']
  end

  def set_grid(grid)
    @grid = grid
  end
end
