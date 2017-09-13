class MockConfig
  attr_reader :user_interface, :game_script, :player_validator

  def initialize(user_interface, game_script, player_validator)
    @user_interface = user_interface
    @game_script = game_script
    @player_validator = player_validator
  end
end
