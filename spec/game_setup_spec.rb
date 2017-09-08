require_relative '../lib/util/game_setup.rb'
require_relative './mocks/mock_user_interface.rb'
require_relative './mocks/mock_config.rb'
require_relative '../lib/validators/setup_validator.rb'

describe GameSetup do
  let(:colorizer) { MockColorizer.new }
  let(:game_script) { GameScript.new(colorizer) }
  let(:user_interface) { MockUserInterface.new }
  let(:config) { MockConfig.new(user_interface, game_script) }
  let(:setup_validator) { SetupValidator.new(game_script) }
  let(:game_setup) { GameSetup.new }

  describe 'get_board_size' do
    it 'returns size 3 when option is selected' do
      user_interface.set_input(['1'])
      expect(game_setup.get_board_size(config, setup_validator)).to eql(3)
    end

    it 'returns size 4 when option is selected' do
      user_interface.set_input(['2'])
      expect(game_setup.get_board_size(config, setup_validator)).to eql(4)
    end
  end

  describe 'get_mode' do
    it 'returns humanVShuman when option is selected' do
      user_interface.set_input(['1'])
      expect(game_setup.get_mode(config, setup_validator)).to eql(:humanVShuman)
    end

    it 'returns humanVScomputer when option is selected' do
      user_interface.set_input(['2'])
      expect(game_setup.get_mode(config, setup_validator)).to eql(:humanVScomputer)
    end

    it 'returns computerVScomputer when option is selected' do
      user_interface.set_input(['3'])
      expect(game_setup.get_mode(config, setup_validator)).to eql(:computerVScomputer)
    end
  end

  describe 'get_token' do
    it 'returns a letter token' do
      user_interface.set_input(['a'])
      expect(game_setup.get_token(config, setup_validator, 'Player 1')).to eql('a')
    end

    it 'tries again if token is not valid' do
      user_interface.set_input(['1', 'a'])
      expect(game_setup.get_token(config, setup_validator, 'Player 1')).to eql('a')
    end

    it 'tries again if token is taken' do
      user_interface.set_input(['a', 'b'])
      game_setup.instance_variable_set(:@token1, 'a')
      expect(game_setup.get_token(config, setup_validator, 'Player 1')).to eql('b')
    end
  end

  describe 'get_order' do
    it 'returns player1 when option is selected' do
      user_interface.set_input(['1'])
      expect(game_setup.get_order(config, setup_validator)).to eql(:player1)
    end

    it 'returns player2 when option is selected' do
      user_interface.set_input(['2'])
      expect(game_setup.get_order(config, setup_validator)).to eql(:player2)
    end
  end

  describe 'get_input' do
    it 'returns given output if valid' do
      user_interface.set_input(['1'])
      expect(game_setup.get_input(user_interface, 'message', setup_validator, ['1'], :mode)).to eql('1')
    end

    it 'keeps getting input and validating until correct' do
      user_interface.set_input(['5', '1'])
      input = game_setup.get_input(user_interface, 'message', setup_validator, ['1'], :mode)
      expect(input).to eql('1')
      expect(user_interface.get_input_calls).to eql(2)
      expect(user_interface.get_display_calls).to eql(1)
    end
  end

  describe 'set_order' do
    it 'returns input unmodified if player 1 is first' do
      expect(game_setup.set_order('a', 'b')).to eql(['a', 'b'])
    end

    it 'flips player order if player 2 is first' do
      game_setup.instance_variable_set(:@order, :player2)
      expect(game_setup.set_order('a', 'b')).to eql(['b', 'a'])
    end
  end
end
