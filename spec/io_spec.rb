require_relative './mocks/mock_stdin.rb'
require_relative './mocks/mock_stdout.rb'
require_relative '../lib/ui/io.rb'

describe 'IO' do
  let(:input) { MockStdin.new}
  let(:output) { MockStdout.new}
  let(:io) { IO.new(input, output) }


  describe 'display_user_message' do
    it 'calls the print method on stdout' do
      io.display_message('message')
      expect(output.times_called).to eql(1)
    end

    it 'receives a messages to display and sends to stdout' do
      io.display_message('message')
      expect(output.check_message).to eql('message')
    end
  end

  describe 'get_user_input' do
    it 'calls the gets method on stdin' do
      io.get_input
      expect(input.times_called).to eql(1)
    end

    it 'receives user input from stdin' do
      io.get_input
      expect(input.gets).to eql('input')
    end
  end
end
