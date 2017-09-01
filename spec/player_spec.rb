require_relative '../lib/players/player.rb'
require_relative '../lib/players/ai.rb'
require_relative '../lib/players/human.rb'
require_relative '../lib/players/player_script.rb'
require_relative '../lib/players/validator.rb'
require_relative '../lib/board/board_checker.rb'

describe Player do
  let(:board) { Board.new(3, '-')}
  let(:checker) { BoardChecker.new(board) }
  let(:user_interface) { MockUserInterface.new }
  let(:validator) { Validator.new(board) }
  let(:human) { Human.new(user_interface) }
  let(:script) { PlayerScript.new('get move', 'announce move')}
  let(:player) { Player.new(script, human, 'O', user_interface, validator) }

  describe 'get_move' do
    it 'gets a move from the player, retries until valid, and returns it' do
      player.get_move(9)
      expect(user_interface.times_displayed).to eql(3)
    end
  end
end
