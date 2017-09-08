class GameScript
  attr_reader :welcome, :board_size, :token_selection, :invalid_token, :mode_selection, :taken_token, :player_order, :game_over, :draw, :game_end, :errors

  def initialize
    @welcome = "\nWelcome to Tic Tac Toe.\n\nTo play, pick a number between 1 - 9 to place a token on the board.\nThe first player with three in a row wins.\n\nIf you'd like to stop playing, you can enter 'exit' to stop.\n"
    @board_size = "\nPlease select a board size:\n\n     [1] 3x3, or\n     [2] 4x4.\n\nChoice: "
    @mode_selection = "\nPlease select a game mode:\n\n     [1] human vs. human,\n     [2] human vs. computer,\n     [3] computer vs. computer.\n\nChoice: "
    @token_selection = "\nPlease select a token for "
    @invalid_token = "Not a valid token. Pick a single character.\n"
    @taken_token = "This token has been selected. Pick again.\n"
    @player_order = "\nPlease select who should go first:\n\n     [1] Player 1, or\n     [2] Player 2.\n\nChoice: "
    @game_over = "\n\nGame over. "
    @draw = "It's a draw.\n"
    @game_end = "\n\nThanks for playing.\n"
    @errors = {
      mode: "\nNot a valid selection. Pick again.\n",
      order: "\nNot a valid selection. Pick again.\n",
      token: "\nPlease enter a single letter which hasn't already been selected.\n",
      board: "\nNot a valid selection. Pick again.\n"
    }
  end

  def create_token_prompt(player)
    "#{@token_selection}#{player}: "
  end
end
