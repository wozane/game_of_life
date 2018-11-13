class Cell
  attr_accessor :row, :column

  def initialize(row = 0, column = 0)
    @row = row
    @column = column
  end

  def create_cell(row, column)
    Cell.new(row, column)
  end

  def neighbours
    0
  end
end

class Board
  attr_accessor :rows, :columns

  def initialize(rows = 0, columns = 0)
    @rows = rows
    @columns = columns
  end
end
