require_relative './lib/game.rb'
require_relative './lib/board/board.rb'
require_relative './lib/board/board_checker.rb'
require_relative './lib/players/player.rb'
require_relative './lib/players/ai.rb'
require_relative './lib/players/human.rb'
require_relative './lib/ui/user_interface.rb'
require_relative './lib/ui/io.rb'

def initializer(size, token1, token2)
  human_script = {
    get_move: "\nPlease enter a number between 1 - 9: ",
    announce_move: "\nYou picked spot "
  }
  ai_script = {
    get_move: "\nThe computer is picking a spot...",
    announce_move: "\nThe computer picks spot "
  }

  board = Board.new(size, '-')
  checker = BoardChecker.new(3, '-')
  io = IO.new(STDIN, STDOUT)
  user_interface = UserInterface.new(io, board, token1, token2)
  human = Human.new(board, user_interface, token1)
  ai = AI.new(checker, token2, token1)
  player1 = Player.new(human_script, human, token1, user_interface)
  player2 = Player.new(ai_script, ai, token2, user_interface)
  game = Game.new(board, checker, player1, player2)

  user_interface.welcome
  game.play
end

initializer(3, 'X', 'O')
