require 'rspec'
require_relative 'game_of_life'

describe 'Game of life' do
  context 'Board' do
    subject { Board.new }

    it 'initializes' do
      subject.is_a?(Board).equal? true
    end

    it 'responds to rows() and columns()' do
      expect(subject).to respond_to(:rows)
      expect(subject).to respond_to(:columns)
    end
  end

  context 'Cell' do
    subject { Cell.new }

    it 'initializes' do
      subject.is_a?(Cell).equal? true
    end

    it 'is created' do
      cell = subject.create_cell(1, 2)
      expect(cell.row).to be(1)
      expect(cell.column).to be(2)
    end

    it '#1: cell with fewer than 2 neighbours dies' do
      expect(subject.neighbours).to equal(0)
    end
  end
end
