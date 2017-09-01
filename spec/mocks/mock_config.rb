class MockConfig
  attr_reader :user_interface, :game_script

  def initialize(user_interface, game_script)
    @user_interface = user_interface
    @game_script = game_script
  end
end
