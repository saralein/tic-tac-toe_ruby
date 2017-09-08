class PlayerScript
  attr_reader :get_move, :announce_move

  def initialize(get_move, announce_move)
    @get_move = get_move
    @announce_move = announce_move
  end
end
