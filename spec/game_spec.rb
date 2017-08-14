require_relative '../lib/game.rb'

describe 'Game' do
  let(:ask_for_move) { 'Please enter a number between 1 - 9: ' }
  let(:game) { Game.new(3) }

  describe 'get_player_move' do
    context 'when it is the players turn' do
      it 'asks for players move and returns as integer' do
        allow(game).to receive(:gets).and_return('9')
        expect(STDOUT).to receive(:puts).with(ask_for_move)
        expect(game.get_player_move).to eql(9)
      end
    end
  end
end
