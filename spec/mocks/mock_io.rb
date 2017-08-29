class MockIO
  def initialize
    @message = ''
    @message_called = 0
    @input_called = 0
    @input = 'YES'
  end

  def display_message(message)
    @message = message
    @message_called += 1
  end

  def get_input(message)
    @input
  end

  def set_input(input)
    @input = input
  end

  def check_message_received
    @message
  end

  def check_message_calls
    @message_called
  end

  def check_input_calls
    @input_called = 0
  end
end
