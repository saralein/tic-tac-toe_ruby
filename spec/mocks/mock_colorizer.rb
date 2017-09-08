class MockColorizer
  def initialize
    @green_called = 0
    @magenta_called = 0
  end

  def dim(string)
    string
  end

  def green(string)
    @green_called += 1
    string
  end

  def magenta(string)
    @magenta_called += 1
    string
  end

  def blue(string)
    string
  end

  def yellow(string)
    string
  end

  def reset_calls
    @green_called = 0
    @magenta_called = 0
  end

  def get_green_calls
    @green_called
  end

  def get_magenta_calls
    @magenta_called
  end
end
