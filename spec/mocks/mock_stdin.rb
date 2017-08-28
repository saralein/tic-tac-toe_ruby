class MockStdin
  def initialize
    @input = 'input'
    @called = 0
    @message = ''
  end

  def readline(message)
    @message = message
    @called += 1
    @input
  end

  def check_message
    @message
  end

  def times_called
    @called
  end

  def set_input(input)
    @input = input
  end
end
