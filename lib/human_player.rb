class HumanPlayer
  attr_accessor :token

  def initialize(token)
    @token = token
  end

  def get_move
    begin
      puts'Please enter a number between 1 - 9: '
      move = Integer(gets.chomp) - 1
    rescue => error
      puts 'Your selection is not an integer.'
      retry
    end
    return move
  end
end
