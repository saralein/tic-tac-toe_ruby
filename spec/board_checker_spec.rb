require_relative '../lib/board/board_checker.rb'

describe BoardChecker do
  let(:grid) { [1, 2, 3, 4, 5, 6, 7, 8, 9] }
  let(:rows) { [[1, 2, 3], [4, 5, 6], [7, 8, 9]] }
  let(:columns) { [[1, 4, 7], [2, 5, 8], [3, 6, 9]] }
  let(:diagonals) { [[1, 5, 9], [3, 5, 7]] }
  let(:turns_taken) { ['-', 'O', '-', 'O', 'X', 'O', 'X', '-', 'X'] }
  let(:full_row) { ['-', 'O', '-', 'O', 'X', 'O', 'X', 'X', 'X'] }
  let(:full_column) { ['-', 'X', '-', 'O', 'X', 'O', 'X', 'X', '-'] }
  let(:full_diagonal) { ['-', 'O', 'X', 'O', 'X', '-', 'X', '-', 'O'] }
  let(:empty_patterns) { [['-', '-', '-'], ['-', '-', '-']] }
  let(:winning_pattern) { [['-', '-', '-'], ['X', 'X', 'X']] }

  before(:each) do
    @checker = BoardChecker.new(3, '-')
  end

  describe 'game_over?' do
    context 'when checking if the game is over' do
      it 'returns true if there is a draw' do
        expect(@checker.game_over?(grid, 0)).to eql(true)
      end

      it 'returns false if there is not a draw' do
        expect(@checker.game_over?(grid, 5)).to eql(false)
      end

      it 'returns false when game is not won or a draw' do
        expect(@checker.game_over?(turns_taken, 3)).to eql(false)
      end

      it 'returns true when game is won' do
        expect(@checker.game_over?(full_row, 2)).to eql(true)
      end
    end
  end

  describe 'winner?' do
    context 'when given a grid' do
      it 'returns false if there is no winner' do
        expect(@checker.winner?(grid)).to eql(false)
      end

      it 'returns true when a row is full' do
        expect(@checker.winner?(full_row)).to eql(true)
      end

      it 'returns true when a column is full' do
        expect(@checker.winner?(full_column)).to eql(true)
      end

      it 'returns true when a diagonal is full' do
        expect(@checker.winner?(full_diagonal)).to eql(true)
      end
    end
  end

  describe 'draw?' do
    context 'when given remaining number of turns' do
      it 'returns true if no turns remain' do
        expect(@checker.draw?(0)).to eql(true)
      end

      it 'returns false if there are turns remaining' do
        expect(@checker.draw?(8)).to eql(false)
      end
    end
  end

  describe 'get_rows' do
    context 'when given a grid and size' do
      it 'returns a nested array of rows (slices)' do
        expect(@checker.get_rows(grid)).to eql(rows)
      end
    end
  end

  describe 'get_columns' do
    context 'when given rows' do
      it 'returns a nested array of columns' do
        expect(@checker.get_columns(rows)).to eql(columns)
      end
    end
  end

  describe 'get_diagonals' do
    context 'when given rows' do
      it 'returns a nested array of diagonals' do
        expect(@checker.get_diagonals(rows)).to eql(diagonals)
      end
    end
  end

  describe 'get_winner' do
    context 'when given a nest array of patterns' do
      it 'returns empty string when there is no winner' do
        expect(@checker.get_winner(empty_patterns)).to eql('')
      end

      it 'returns the winning token when there is a winner' do
        expect(@checker.get_winner(winning_pattern)).to eql('X')
      end
    end
  end

  describe 'set_winner' do
    context 'when given a token' do
      it 'sets winner to token' do
        @checker.set_winner('X')
        expect(@checker.instance_variable_get(:@winner)).to eql('X')
      end
    end
  end
end
