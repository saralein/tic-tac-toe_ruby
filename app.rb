require 'readline'
require_relative './lib/game.rb'
require_relative './lib/util/game_runner.rb'
require_relative './lib/board/board.rb'
require_relative './lib/board/board_checker.rb'
require_relative './lib/players/player.rb'
require_relative './lib/players/ai.rb'
require_relative './lib/players/human.rb'
require_relative './lib/scripts/player_script.rb'
require_relative './lib/validators/player_validator.rb'
require_relative './lib/ui/user_interface.rb'
require_relative './lib/ui/io.rb'
require_relative './lib/scripts/game_script.rb'
require_relative './lib/validators/setup_validator.rb'
require_relative './lib/util/game_setup.rb'
require_relative './lib/util/game_progress.rb'
require_relative './lib/util/game_configuration.rb'

def initializer
  game_setup = GameSetup.new
  configuration = game_setup.setup

  game = Game.new(configuration.game_progress, configuration.board,
                  configuration.checker, configuration.player1,
                  configuration.player2)

  game_runner = GameRunner.new(game, configuration.user_interface)
  game_runner.start_playing
end
