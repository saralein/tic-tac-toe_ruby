require_relative '../lib/validators/setup_validator.rb'
require_relative '../lib/scripts/game_script.rb'
require_relative './mocks/mock_user_interface.rb'

describe SetupValidator do
  let(:colorizer) { MockColorizer.new }
  let(:script) { GameScript.new(colorizer) }
  let(:setup_validator) { SetupValidator.new(script)}
  let(:user_interface) { MockUserInterface.new }

  describe 'get_mode' do
    it 'returns the correct symbol give a mode' do

    end
  end

  describe 'validate_input' do
    it 'does not raise an error if a token is valid' do
      expect{ setup_validator.validate_input('a', ['a', 'b'], :token) }.to_not raise_error
    end

    it 'raises an error for empty string' do
      expect{ setup_validator.validate_input('', ['a', 'b'], :token) }.to raise_error(script.errors[:token])
    end

    it 'raises an error for srting with length greater than one' do
      expect{ setup_validator.validate_input('ab', ['a', 'b'], :mode) }.to raise_error(script.errors[:mode])
    end
  end
end
