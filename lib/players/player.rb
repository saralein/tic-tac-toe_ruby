class Player
  def initialize(behavior, token, user_interface)
    @behavior = behavior
    @token = token
    @user_interface = user_interface
  end

  def take_turn(board, turns_remaining)
    grid = board.grid
    move = get_move(grid, turns_remaining)
    add_move(board, move)
    display_board(grid)
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

  def end_game(winner)
    @user_interface.end_game(winner)
  end
end
