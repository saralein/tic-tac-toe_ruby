require 'readline'
require_relative './lib/game.rb'
require_relative './lib/board/board.rb'
require_relative './lib/board/board_checker.rb'
require_relative './lib/players/player.rb'
require_relative './lib/players/ai.rb'
require_relative './lib/players/human.rb'
require_relative './lib/players/player_script.rb'
require_relative './lib/players/validator.rb'
require_relative './lib/ui/user_interface.rb'
require_relative './lib/ui/io.rb'

def initializer(size, token1, token2)
  state = {is_playing: true, stop_playing: false, is_won: false}
  board = Board.new(size, '-')
  checker = BoardChecker.new(board)
  io = IO.new(Readline, STDOUT)
  user_interface = UserInterface.new(io, board, token1, token2)
  validator = Validator.new(board)
  human = Human.new(user_interface)
  human_script = PlayerScript.new("\nPlease enter a number between 1 - 9: ", "\nYou picked spot ")
  ai = AI.new(board, checker, token2, token1)
  ai_script = PlayerScript.new("\nThe computer is picking a spot...", "\nThe computer picks spot ")
  player1 = Player.new(human_script, human, token1, user_interface, validator)
  player2 = Player.new(ai_script, ai, token2, user_interface, validator)
  game = Game.new(state, board, checker, player1, player2)

  trap_signals(user_interface)

  while(state[:is_playing])
    state[:is_playing] = false
    user_interface.welcome
    game.play
  end

  stop_playing(user_interface)
end

def trap_signals(user_interface)
  signals = ['INT', 'TERM', 'QUIT','ABRT', 'TSTP']

  signals.each do |signal|
    trap(signal) do
      stop_playing(user_interface)
    end
  end
end

def stop_playing(user_interface)
  user_interface.exit_game
  exit
end

initializer(3, 'X', 'O')
