class GameConfiguration
  attr_reader :game_progress, :board, :checker, :game_script, :user_interface, :player_validator, :player1, :player2

  def initialize(game_progress, board, checker, game_script, user_interface, player_validator)
    @game_progress = game_progress
    @board = board
    @checker = checker
    @game_script = game_script
    @user_interface = user_interface
    @player_validator = player_validator
  end

  def set_players(player1, player2)
    @player1 = player1
    @player2 = player2
  end
end
