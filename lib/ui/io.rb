class IO
  def initialize(input, output)
    @input, @output = input, output
  end

  def display_user_message(message)
    @output.print message
  end

  def get_user_input
    @input.gets.chomp
  end
end
