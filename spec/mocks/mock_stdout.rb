class MockStdout
  def initialize
    @message = ''
    @called = 0
  end

  def print(message)
    @message = message
    @called += 1
  end

  def check_message
    @message
  end

  def times_called
    @called
  end
end
