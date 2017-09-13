require_relative '../lib/scripts/game_script.rb'

describe GameScript do
  let(:colorizer) { MockColorizer.new }
  let(:script) { GameScript.new(colorizer) }
  let(:emojis) { ["\u{1f4a9}", "\u{1f60e}", "\u{1f4a9}", "\u{1f60e}", "\u{1f4a9}", "\u{1f60e}", "\u{1f4a9}", "\u{1f60e}", "\u{1f4a9}", "\u{1f60e}", "\u{1f4a9}", "\u{1f60e}"]}
  let(:string_array) {["[1]   💩", "[2]   😎", "[3]   💩", "[4]   😎" ,"[5]   💩", "[6]   😎", "[7]   💩", "[8]   😎", "[9]   💩", "[10]  😎", "[11]  💩", "[12]  😎"]}
  let(:rows) { ["[1]   💩 , [2]   😎 , [3]   💩 , [4]   😎 , [5]   💩 , [6]   😎 , [7]   💩 , [8]   😎 , [9]   💩 , [10]  😎", "[11]  💩 , [12]  😎"]}
  let(:joined_rows) { "[1]   💩 , [2]   😎 , [3]   💩 , [4]   😎 , [5]   💩 , [6]   😎 , [7]   💩 , [8]   😎 , [9]   💩 , [10]  😎 ,\n     [11]  💩 , [12]  😎" }
  let(:token_prompt) { "\nPlease select a token for Player 1.\n\n     [1]   💩 , [2]   😎 .\n\n Choice: "}
  let(:longer_prompt) { "\nPlease select a token for Player 1.\n\n     [1]   💩 , [2]   😎 , [3]   💩 , [4]   😎 , [5]   💩 , [6]   😎 , [7]   💩 , [8]   😎 , [9]   💩 , [10]  😎 ,\n     [11]  💩 , [12]  😎 .\n\n Choice: " }
  let(:move_prompt) { ""}

  describe 'create_token_prompt' do
    it 'returns a prompt asking player to select token' do
      expect(script.create_token_prompt(["\u{1f4a9}", "\u{1f60e}"], 'Player 1')).to eql(token_prompt)
    end

    it 'creates rows of emojis if applicable' do
      expect(script.create_token_prompt(emojis, 'Player 1')).to eql(longer_prompt)
    end
  end

  describe 'create_emoji_strings' do
    it 'returns an array of strings' do
      (expect(script.create_emoji_strings(emojis))).to eql(string_array)
    end
  end

  describe 'make_emoji_rows' do
    it 'returns an array of joined rows' do
      (expect(script.make_emoji_rows(string_array))).to eql(rows)
    end
  end

  describe 'join_emoji_rows' do
    it 'returns aa string of joined emoji rows' do
      (expect(script.join_emoji_rows(rows))).to eql(joined_rows)
    end
  end
end
