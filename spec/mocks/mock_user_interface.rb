class MockUserInterface
  def initialize
    @paused = 0
    @message = ''
    @input = 11
    @message_called = 0
  end

  def pause
    @paused += 1
  end

  def display_message(message)
    @message = message
    @message_called += 1
  end

  def get_input(message)
    return_value = @input.to_s
    @input -= 1
    return_value
  end

  def times_paused
    @paused
  end

  def check_message
    @message
  end

  def times_displayed
    @message_called
  end
end
