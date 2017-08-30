class HumanScript
  attr_reader :get_move, :announce_move

  def initialize
    @get_move = "\nPlease enter a number between 1 - 9: "
    @announce_move = "\nYou picked spot "
  end
end
