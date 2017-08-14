class Board
  attr_accessor :moves

  def initialize(size)
    @moves
    @size = size
  end

  def createNewBoard
    @moves = Array.new(@size){ Array.new(@size){'-'} }
  end

  def displayBoard
    output = ''
    @moves.each_with_index do |row, row_index|
      row.each_with_index do |spot, spot_index|
        output += spot == '-' ? ' ' : spot
        if (spot_index != @size - 1)
          output += '|'
        end
      end
      if (row_index != @size - 1)
        output += "\n - + - + - \n"
      end
    end
    puts output
  end
end
