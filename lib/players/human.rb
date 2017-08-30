class Human
  attr_reader :token, :script

  def initialize(user_interface)
    @user_interface = user_interface
  end

  def get_move(turns_remaining)
    @user_interface.get_input
  end
end
