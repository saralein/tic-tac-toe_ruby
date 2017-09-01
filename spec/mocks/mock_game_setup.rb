class MockGameSetup
  def get_game_options
    Struct.new('GameConfig', :token1, :token2)
    config = Struct::GameConfig.new('X', 'O')
  end
end
