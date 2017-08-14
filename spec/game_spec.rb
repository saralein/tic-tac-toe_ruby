require_relative '../lib/game.rb'

describe 'Game' do
  let(:ask_for_move) { 'Please enter a number between 1 - 9: ' }
  let(:game) { Game.new(3) }
  let(:flattened_moves) {
    [
      '-', '-', '-',
      '-', '-', '-',
      '-', '-', '-'
    ]
  }

  describe 'get_player_move' do
    context "when it is the player's turn" do
      it 'asks for players move and returns as integer' do
        allow(game).to receive(:gets).and_return('9')
        expect(STDOUT).to receive(:puts).with(ask_for_move)
        expect(game.get_player_move).to eql(8)
      end
    end
  end

  describe 'get_computer_move' do
    context "when it is the computer's turn" do
      it 'returns an spot which has not been taken' do
        allow(game).to receive(:gets).and_return('9')
        allow(STDOUT).to receive(:puts).twice
        game.get_player_move
        expect(game.get_computer_move).not_to eql(8)
      end
    end
  end
end
