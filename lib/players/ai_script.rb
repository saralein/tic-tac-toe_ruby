class AIScript
  attr_reader :get_move, :announce_move

  def initialize
    @get_move = "\nThe computer is picking a spot..."
    @announce_move = "\nThe computer picks spot "
  end
end
