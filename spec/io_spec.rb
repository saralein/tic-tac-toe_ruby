require_relative './mocks/mock_stdin.rb'
require_relative './mocks/mock_stdout.rb'
require_relative '../lib/ui/io.rb'

describe 'IO' do
  let(:input) { MockStdin.new}
  let(:output) { MockStdout.new}
  let(:io) { IO.new(input, output) }

  describe 'display_message' do
    it 'displays a given message in the UI' do
      io.display_message('message')
      expect(output.times_called).to eql(1)
      expect(output.check_message).to eql('message')
    end
  end

  describe 'get_input' do
    it 'receives input from the user' do
      expect(io.get_input('message')).to eql('input')
      expect(input.check_message).to eql('message')
      expect(input.times_called).to eql(1)
    end

    it 'exits the game if EOFError passes nil' do
      input.set_input(nil)
      expect(io.get_input('message')).to eql(:exit)
    end
  end
end
