class Game
  def get_player_move
    puts 'Please enter a number between 1 - 9: '
    return Integer(gets.chomp)
  end
end
