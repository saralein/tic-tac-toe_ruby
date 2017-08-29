class Player
  def initialize(behavior, token, user_interface)
    @behavior = behavior
    @token = token
    @user_interface = user_interface
  end

  def take_turn(board, turns_remaining)
    display_board(board.grid)
    move = get_move(board.grid, turns_remaining)
    add_move(board, move)
    display_board(board.grid)
    announce_move(move)
  end

  def get_move(grid, turns_remaining)
    move = @behavior.get_move(grid, turns_remaining, @user_interface)

    return move
  end

  def announce_move(move)
    @behavior.announce_move(move, @user_interface)
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
