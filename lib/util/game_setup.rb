class GameSetup
  @@modes = {'1' => :humanVShuman, '2' => :humanVScomputer, '3' => :computerVScomputer}
  @@player_order = {'1' => :player1, '2' => :player2}
  @@board_sizes = {'1' => 3, '2' => 4}

  def initialize
    @token1 = ''
    @token2 = ''
    @size = 3
    @mode = :computerVScomputer
    @order = :player1
  end

  def setup
    game_progress = GameProgress.new
    board = Board.new(@size, '-')
    io = IO.new(Readline, STDOUT)
    colorizer = Colorizer.new
    game_script = GameScript.new(colorizer)
    user_interface = UserInterface.new(io, game_script, board, colorizer)
    checker = BoardChecker.new(board)
    setup_validator = SetupValidator.new(game_script)
    player_validator = PlayerValidator.new(board, game_script)
    config = GameConfiguration.new(game_progress, board, checker, game_script, user_interface, player_validator)

    user_interface.welcome
    get_game_options(config, setup_validator)
    board.reset(@size)
    player1, player2 = send(@mode, config)
    player1, player2 = set_order(player1, player2)
    config.set_players(player1, player2)

    config
  end

  def get_game_options(config, setup_validator)
    @size = get_board_size(config, setup_validator)
    @mode = get_mode(config, setup_validator)
    @token1 = get_token(config, setup_validator, 'Player 1')
    @token2 = get_token(config, setup_validator, 'Player 2')
    @order = get_order(config, setup_validator)
  end

  def get_board_size(config, setup_validator)
    selection = get_input(config.user_interface, config.game_script.board_size, setup_validator, @@board_sizes.keys, :board)
    @@board_sizes[selection]
  end

  def get_mode(config, setup_validator)
    selection = get_input(config.user_interface, config.game_script.mode_selection, setup_validator, @@modes.keys, :mode)
    @@modes[selection]
  end

  def get_token(config, setup_validator, player)
    letters = [*('a'..'z'), *('A'..'Z')]

    if(letters.include?(@token1))
      letters.delete(@token1)
    end

    prompt = config.game_script.create_token_prompt(player)
    get_input(config.user_interface, prompt, setup_validator, letters, :token)
  end

  def get_order(config, setup_validator)
    selection = get_input(config.user_interface, config.game_script.player_order, setup_validator, @@player_order.keys, :order)
    @@player_order[selection]
  end

  def get_input(user_interface, script, setup_validator, choices, error_key)
    begin
      input = user_interface.get_input(script).strip
      setup_validator.validate_input(input, choices, error_key)
    rescue => error
      user_interface.display_message(error)
      retry
    end
    input
  end

  def set_order(player1, player2)
    if(@order == :player2)
      player1, player2 =  player2, player1
    end

    [player1, player2]
  end

  def humanVShuman(config)
    human_script = PlayerScript.new("\nPlease enter a number between 1 - 9: ", "\nYou picked spot ")
    behavior1 = Human.new(config.user_interface)
    player1 = Player.new(human_script, behavior1, @token1, config.user_interface, config.player_validator)
    player2 = Player.new(human_script, behavior1, @token2, config.user_interface, config.player_validator)
    [player1, player2]
  end

  def humanVScomputer(config)
    human_script = PlayerScript.new("\nPlease enter a number between 1 - 9: ", "\nYou picked spot ")
    ai_script = PlayerScript.new("\nThe computer is picking a spot...", "\nThe computer picks spot ")
    behavior1 = Human.new(config.user_interface)
    behavior2 = AI.new(config.board, config.checker, @token2, @token1)
    player1 = Player.new(human_script, behavior1, @token1, config.user_interface, config.player_validator)
    player2 = Player.new(ai_script, behavior2, @token2, config.user_interface, config.player_validator)
    [player1, player2]
  end

  def computerVScomputer(config)
    ai_script = PlayerScript.new("\nThe computer is picking a spot...", "\nThe computer picks spot ")
    behavior1 = AI.new(config.board, config.checker, @token1, @token2)
    behavior2 = AI.new(config.board, config.checker, @token2, @token1)
    player1 = Player.new(ai_script, behavior1, @token1, config.user_interface, config.player_validator)
    player2 = Player.new(ai_script, behavior2, @token2, config.user_interface, config.player_validator)
    [player1, player2]
  end
end
