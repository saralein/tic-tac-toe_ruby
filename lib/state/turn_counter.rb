class TurnCounter
  attr_accessor :total, :remaining

  def initialize(size)
    @total = size * size
    @remaining = @total
  end
end
