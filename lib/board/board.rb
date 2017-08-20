class Board
  attr_accessor :grid, :empty_char, :size

  def initialize(size, empty_char)
    @size = size
    @empty_char = empty_char
    @grid = create_grid
  end

  def create_grid
    return Array.new(@size**2){ @empty_char }
  end

  def add_move(move, player_token)
    @grid[move] = player_token
  end
end
