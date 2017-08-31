class Player
  def initialize(behavior, token, user_interface)
    @behavior = behavior
    @token = token
    @user_interface = user_interface
  end

  def take_turn(state, board, turns_remaining)
    grid = board.grid
    move = get_move(grid, turns_remaining)
    wants_to_exit?(state, move)

    unless(state[:stop_playing])
      add_move(board, move)
      display_board(grid)
    end
  end

  def get_move(grid, turns_remaining)
    move = @behavior.get_move(grid, turns_remaining)

    if(@behavior.is_a? AI)
      @user_interface.ai_move(move)
    end

    return move
  end

  def add_move(board, move)
    board.add_move(move, @token)
  end

  def display_board(grid)
    @user_interface.display_board(grid)
  end

  def wants_to_exit?(state, move)
    state[:stop_playing] = move == :exit
  end

  def end_game(winner)
    @user_interface.end_game(winner)
  end
end
