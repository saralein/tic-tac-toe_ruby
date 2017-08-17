require_relative '../lib/game.rb'

describe 'Game' do
  let(:game) { Game.new(3) }

  describe 'prep_turn' do
    context 'before the turn' do
      it 'does not update current player if first turn' do
        game.prep_turn
        expect(game.instance_variable_get(:@current_player)).to be(game.instance_variable_get(:@player1))
      end

      it 'updates the current player if not the first turn' do
        game.instance_variable_get(:@turn_counter).remaining = 8
        game.prep_turn
        expect(game.instance_variable_get(:@current_player)).to be(game.instance_variable_get(:@player2))
        game.instance_variable_get(:@turn_counter).remaining = 7
        game.prep_turn
        expect(game.instance_variable_get(:@current_player)).to be(game.instance_variable_get(:@player1))
      end
    end
  end

  describe 'end_game' do
    it 'announces the end of the game' do
      expect(STDOUT).to receive(:puts)
      game.end_game
    end

    it 'includes the human winner' do
      game.instance_variable_get(:@board).actual_state.winner = 'X'
      expect(STDOUT).to receive(:puts).with("\nGame over. You win!")
      game.end_game
    end

    it 'includes the computer winner' do
      game.instance_variable_get(:@board).actual_state.winner = 'O'
      expect(STDOUT).to receive(:puts).with("\nGame over. The computer wins!")
      game.end_game
    end

    it 'notifies of a draw' do
      game.instance_variable_get(:@board).actual_state.winner = '-'
      expect(STDOUT).to receive(:puts).with("\nGame over. It's a draw.")
      game.end_game
    end
  end
end
