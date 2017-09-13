class MockUserInterface
  def initialize
    @paused = 0
    @message = ''
    @display_called = 0
    @input = []
    @index = 0
    @colors = {'X': :magenta, 'O': :green}
  end

  def pause
    @paused += 1
  end

  def display_message(message)
    @message = message
    @display_called += 1
  end

  def get_input(message)
    return_value = @input[@index]
    @message = message
    @index += 1
    return_value
  end

  def times_paused
    @paused
  end

  def check_message
    @message
  end

  def welcome
  end

  def assign_color(token)
  end

  def ai_move(move)
  end

  def display_message(message)
    @display_called += 1
  end

  def set_input(input)
    @index = 0
    @input = input
  end

  def get_display_calls
    @display_called
  end

  def get_input_calls
    @index
  end

  def clear
  end

  def display_board
  end
end
