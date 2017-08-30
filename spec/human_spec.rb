require_relative '../lib/players/human.rb'
require_relative '../lib/board/board.rb'
require_relative './mocks/mock_user_interface.rb'

describe Human do
  let(:user_interface) { MockUserInterface.new }
  let(:human) { Human.new(user_interface)}

  describe 'get_move' do
    it 'gets a move from the player' do
      expect(human.get_move(9)).to eql('11')
    end
  end
end
