class SetupValidator
  def initialize(script)
    @script = script
  end

  def validate_input(input, choices, error_key)
    unless(choices.include?(input))
      raise @script.errors[error_key]
    end
  end
end
