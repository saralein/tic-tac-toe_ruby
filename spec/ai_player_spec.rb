require_relative '../lib/ai_player.rb'
require_relative '../lib/board.rb'

describe AIPlayer do
  let(:board) { Board.new(3) }
  let(:ai_player) { AIPlayer.new(board) }

  def set_depth(number)
    ai_player.instance_variable_set(:@depth, number)
  end

  describe 'minimax' do
    it 'returns zero when depth is zero' do
      set_depth(0)
      ai_player.minimax
    end
  end

  describe 'score' do
    it 'returns zero when there is a draw' do
      expect(ai_player.score('draw')).to eql(0)
    end

    it 'returns the correct score for max player based on turns taken' do
      expect(ai_player.score('max')).to eql(19)
      set_depth(3)
      expect(ai_player.score('max')).to eql(13)
    end

    it 'returns the correct score for min player based on turns taken' do
      expect(ai_player.score('min')).to eql(-19)
      set_depth(5)
      expect(ai_player.score('min')).to eql(-15)
    end
  end
end
