class Player
  attr_reader :token
  def initialize(script, behavior, token, user_interface, validator)
    @script = script
    @behavior = behavior
    @token = token
    @user_interface = user_interface
    @validator = validator
    @user_interface.assign_color(@token)
  end

  def take_turn(state, board, turns_remaining)
    grid = board.grid
    display_board
    move = get_move(turns_remaining)
    wants_to_restart?(state, move)
    wants_to_exit?(state, move)

    unless(state.stop_playing || state.restart)
      add_move(board, move)
      display_board
      announce_move(move)
    end
  end

  def get_move(turns_remaining)
    begin
      move = @behavior.get_move(@script.get_move, turns_remaining)
      return :restart if move == :restart.to_s
      return :exit if move == :exit.to_s
      move = @validator.validate_move(move)
    rescue => error
      display_board
      @user_interface.display_message(error)
      retry
    end
    display_board
    @user_interface.pause
    move
  end

  def announce_move(move)
    @user_interface.display_message("#{@script.announce_move}#{move + 1}.")
    @user_interface.pause(1.5)
  end

  def add_move(board, move)
    board.add_move(move, @token)
  end

  def display_board
    @user_interface.display_board
  end

  def wants_to_restart?(state, move)
      state.restart = move == :restart
  end

  def wants_to_exit?(state, move)
    state.stop_playing = move == :exit
  end

  def end_game(winner)
    @user_interface.end_game(winner)
  end
end
