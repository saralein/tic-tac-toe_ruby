class IO
  def initialize(input, output)
    @input, @output = input, output
  end

  def clear
    system('clear')
  end

  def pause(amount = 1)
    sleep amount
  end

  def display_message(message)
    @output.print message
  end

  def get_input(message)
    input = @input.readline(message)
    unless(input)
      return :exit
    end
    input
  end
end
