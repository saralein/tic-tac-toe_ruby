require_relative '../lib/ai_player.rb'
require_relative '../lib/board.rb'

describe AIPlayer do
  let(:board) { Board.new(3) }
  let(:ai_player) { AIPlayer.new(board) }

  def set_projected_winner(winner)
    ai_player.instance_variable_set(:@projected_winner, winner)
  end

  def set_depth(number)
    ai_player.instance_variable_set(:@depth, number)
  end

  describe 'score' do
    it 'returns zero when there is a draw' do
      set_projected_winner('draw')
      expect(ai_player.score).to eql(0)
    end

    it 'returns the correct score for max player based on turns taken' do
      set_projected_winner('max')
      expect(ai_player.score).to eql(19)
      set_depth(3)
      expect(ai_player.score).to eql(13)
    end

    it 'returns the correct score for min player based on turns taken' do
      set_projected_winner('min')
      expect(ai_player.score).to eql(-19)
      set_depth(5)
      expect(ai_player.score).to eql(-15)
    end
  end
end
