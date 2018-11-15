require 'rspec'
require_relative 'game_of_life'

describe 'Game of life' do
  let!(:board) { Board.new }
  let!(:cell) { Cell.new(1, 1) }

  context 'Board' do
    subject { Board.new }

    it 'initializes' do
      expect(subject).to be_truthy
    end

    it 'responds to rows() and columns()' do
      expect(subject).to respond_to(:rows)
      expect(subject).to respond_to(:columns)
      expect(subject).to respond_to(:cells_board)
      expect(subject).to respond_to(:neighbours)
    end

    it 'creates itself i.e. board :)' do
      expect(subject.cells_board).to be_instance_of(Array)

      subject.cells_board.each do |row|
        expect(row).to be_instance_of(Array)
      end
    end

    it 'checks count neighbours' do
      expect(subject.cells_board[0][1]).to have_attributes(alive: false)
      new_one = subject.cells_board[0][1]
      new_one.alive = true
      expect(new_one).to have_attributes(alive: true)
      expect(subject.neighbours(subject.cells_board[1][1]).count).to eq(1)
    end

    it 'checks live neighbour to the north' do
      subject.cells_board[cell.row - 1][cell.column].alive = true
      expect(subject.neighbours(cell).count).to eq(1)
    end
  end

  context 'Cell' do
    subject { Cell.new }

    it 'initializes properly' do
      expect(subject).to be_truthy
      expect(subject).to have_attributes(alive: false)
    end

    it 'responds to methods' do
      expect(subject).to respond_to(:alive)
      expect(subject).to respond_to(:row)
      expect(subject).to respond_to(:column)
    end
  end

  context 'Round' do
    subject { Round.new }

    it 'responds to board and cells' do
      expect(subject).to respond_to(:board)
      expect(subject).to respond_to(:cells)
    end

    it 'initializes' do
      expect(subject.board).to match(Board)
      expect(subject.cells).to match([])
    end

    it 'has board with alive cells' do
      first_round = Round.new(board, [[1, 0], [0, 2]])
      expect(board.cells_board[1][0]).to have_attributes(alive: true)
      expect(board.cells_board[0][2]).to have_attributes(alive: true)
    end
  end

  context 'Rule #1' do
    let!(:round) { Round.new }

    it 'Cell dies if there is less than 2 neighbours' do
      first_round = Round.new(board, [[1, 1]])
      first_round.board.cells_board[1][1].alive = true
      expect(first_round.board.cells_board[1][1]).to have_attributes(alive: true)
      first_round.tick!
      expect(first_round.board.cells_board[1][1]).to have_attributes(alive: false)
    end

    it 'Cell lives if there are 2 neighours' do
      game = Round.new(board, )
    end
  end
end
