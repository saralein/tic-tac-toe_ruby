class Player
  def initialize(script, behavior, token, user_interface, validator)
    @script = script
    @behavior = behavior
    @token = token
    @user_interface = user_interface
    @validator = validator
  end

  def take_turn(board, turns_remaining)
    display_board(board.grid)
    move = get_move(turns_remaining)
    add_move(board, move)
    display_board(board.grid)
    announce_move(move)
  end

  def get_move(turns_remaining)
    @user_interface.display_message(@script[:get_move])
    begin
      move = @behavior.get_move(turns_remaining)
      move = @validator.validate_move(move)
    rescue => error
      @user_interface.display_message(error)
      retry
    end
    @user_interface.pause
    move
  end

  def announce_move(move)
    @user_interface.display_message("#{@script[:announce_move]}#{move + 1}.")
    @user_interface.pause(1.5)
  end

  def add_move(board, move)
    board.add_move(move, @token)
  end

  def display_board(grid)
    @user_interface.clear
    @user_interface.display_board(grid)
  end

  def end_game(winner)
    @user_interface.end_game(winner)
  end
end
