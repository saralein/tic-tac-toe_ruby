class MockStdin
  def initialize
    @called = 0
  end

  def gets
    @called += 1
    'input'
  end

  def times_called
    @called
  end
end
