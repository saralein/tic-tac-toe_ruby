require_relative '../../app.rb'

class GameRunner
  def initialize(game, user_interface)
    @game = game
    @user_interface = user_interface
  end

  def start_playing
    trap_signals

    until(@game.state.stop_playing)
      @game.play

      unless(@game.state.restart || @game.state.stop_playing)
        replay?
      end

      if(@game.state.restart)
        initializer
      end
    end

    stop_playing
  end

  def trap_signals
    signals = ['INT', 'TERM', 'QUIT','ABRT', 'TSTP']

    signals.each do |signal|
      trap(signal) do
        stop_playing
      end
    end
  end

  def stop_playing
    @user_interface.exit_game
    exit
  end

  def replay?
    replay = @user_interface.get_input("\nWould you like to replay [y/n]? ").downcase

    if(replay.to_sym == :yes || replay.to_sym == :y)
      @game.state.restart = true
    else
      @game.state.stop_playing = true
    end
  end
end
