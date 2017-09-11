class GameScript
  attr_reader :welcome, :board_size, :token_selection, :invalid_token, :mode_selection, :taken_token, :player_order, :game_over, :draw, :game_end, :errors

  def initialize(colorizer)
    @colorizer = colorizer
    @welcome = "\nWelcome to Tic Tac Toe.\n\nTo play, pick a number between 1 - 9 to place a token on the board.\nThe first player with three in a row wins.\n\nIf you'd like to stop playing, you can enter 'exit' to stop.\n"
    @board_size = "\nPlease select a board size:\n\n     #{colorizer.green('[1]')} 3x3, or\n     #{colorizer.green('[2]')} 4x4.\n\nChoice: "
    @mode_selection = "\nPlease select a game mode:\n\n     #{colorizer.green('[1]')} human vs. human,\n     #{colorizer.green('[2]')} human vs. computer,\n     #{colorizer.green('[3]')} computer vs. computer.\n\nChoice: "
    @token_selection = "\nPlease select a token for "
    @invalid_token = "Not a valid token. Pick a single character.\n"
    @taken_token = "This token has been selected. Pick again.\n"
    @player_order = "\nPlease select who should go first:\n\n     #{colorizer.green('[1]')} Player 1, or\n     #{colorizer.green('[2]')} Player 2.\n\nChoice: "
    @game_over = "\n\nGame over. "
    @draw = "It's a draw.\n"
    @game_end = "\n\nThanks for playing.\n"
    @errors = {
      mode: colorizer.magenta("\nNot a valid selection. Pick again.\n"),
      order: colorizer.magenta("\nNot a valid selection. Pick again.\n"),
      token: colorizer.magenta("\nPlease select a valid token from the list below.\n"),
      board: colorizer.magenta("\nNot a valid selection. Pick again.\n"),
      invalid_spot: colorizer.magenta("\nYour selection is not a valid spot. Pick again.\n"),
      out_of_range: colorizer.magenta("\nYour selection is not between 1 and 9. Pick again.\n"),
      spot_taken: colorizer.magenta("\nThat spot has already been selected. Pick again.\n")
    }
  end

  def create_token_prompt(emojis, player)
    output = "#{@token_selection}#{player}.\n\n     "

    emoji_strings = create_emoji_strings(emojis)
    emoji_rows = make_emoji_rows(emoji_strings)
    full_emoji_string = join_emoji_rows(emoji_rows)

    output += full_emoji_string

    output += " .\n\n Choice: "
  end

  def create_emoji_strings(emojis)
    emojis.each_with_index.map { |code, code_index| "#{colorizer.green("[#{code_index + 1}]".ljust(5, ' '))} #{code}"}
  end

  def make_emoji_rows(emoji_strings)
    emoji_strings.each_slice(10).to_a.map{ |row| row.join(' , ') }
  end

  def join_emoji_rows(emoji_rows)
    emoji_rows.join(" ,\n     ")
  end

  private
  attr_accessor :colorizer
end
