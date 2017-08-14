class Board
  attr_accessor :board

  def initialize
    @board
  end
  def createNewBoard(size)
    @board = Array.new(size){ Array.new(size){'-'} }
  end
end
