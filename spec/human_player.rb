require_relative '../lib/human_player.rb'

describe HumanPlayer do
  let(:player) { HumanPlayer.new('X')}
  let(:ask_for_move) { 'Please enter a number between 1 - 9: ' }

  describe 'get_move' do
    context "when it is the player's turn" do
      it 'asks for players move and returns as integer' do
        allow(human_player).to receive(:gets).and_return('9')
        expect(STDOUT).to receive(:puts).with(ask_for_move)
        expect(human_player.get_move).to eql(8)
      end

      it 'asks for an integer again if integer not given' do
        allow(human_player).to receive(:gets).and_return('a', 'b', '9')
        expect(STDOUT).to receive(:puts).exactly(5).times
        human_player.get_move
      end
    end
  end
end
