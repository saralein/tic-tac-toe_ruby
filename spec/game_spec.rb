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

  describe 'prep_next_move' do
    context 'before the next turn' do
      it 'does not update current player if first turn' do
        game.prep_next_move
        expect(game.instance_variable_get(:@current_player)).to eql('human')
      end

      it 'updates the current player if not the first turn' do
        game.instance_variable_set(:@turns_remaining, 8)
        game.prep_next_move
        expect(game.instance_variable_get(:@current_player)).to eql('computer')
        game.instance_variable_set(:@turns_remaining, 7)
        game.prep_next_move
        expect(game.instance_variable_get(:@current_player)).to eql('human')
      end
    end
  end

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

  describe 'end_game' do
    it 'announces the end of the game' do
      expect(STDOUT).to receive(:puts)
      game.end_game
    end

    it 'includes the correct winner' do
      expect(STDOUT).to receive(:puts).with('Game over. The computer wins!')
      game.instance_variable_set(:@current_player, 'computer')
      game.end_game
    end
  end
end
