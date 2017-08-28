class IO
  def initialize(input, output)
    @input, @output = input, output
  end

  def display_message(message)
    @output.print message
  end

  def get_input(message, callback)
    input = @input.readline(message)
    unless(input)
      callback.call
      exit
    end
    input
  end
end
