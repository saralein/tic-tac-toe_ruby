class GameProgress
  attr_accessor :stop_playing, :is_won, :restart

  def initialize
    @stop_playing = false
    @is_won = false
    @restart = false
  end
end
