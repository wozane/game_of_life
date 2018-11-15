# all cells are dead at the beginning
class Cell
  attr_accessor :alive, :row, :column

  def initialize(row = 0, column = 0)
    @row = row
    @column = column
    @alive = false
  end

  def alive?
    alive
  end

  def dead?
    !alive
  end

  def die!
    @alive = false
  end
end

# it holds the place for the cells
class Board
  attr_accessor :rows, :columns, :cells_board, :cells

  def initialize(rows = 3, columns = 3)
    @rows = rows
    @columns = columns
    @cells_board = Array.new(rows) do |row|
                    Array.new(columns) do |col|
                      Cell.new(col, row) # this can be checked in irb when creating a Board.new
                    end
                  end
    @cells = []

    cells_board.each do |row|
      row.each do |column|
        if column.is_a?(Cell)
          cells << column
        end
      end
    end
  end

  def neighbours(cell)
    neighbours = []

    # north
    if cell.row > 0
      new_cell = cells_board[cell.row - 1][cell.column]
      neighbours << new_cell if new_cell.alive?
    end
    # south
    if cell.row < (rows - 1)
      new_cell = cells_board[cell.row + 1][cell.column]
      neighbours << new_cell if new_cell.alive?
    end
    # east
    if cell.column < (columns - 1)
      new_cell = cells_board[cell.row][cell.column + 1]
      neighbours << new_cell if new_cell.alive?
    end
    # west
    if cell.column > 0
      new_cell = cells_board[cell.row][cell.column - 1]
      neighbours << new_cell if new_cell.alive?
    end
    # north-east
    if cell.row > 0 && cell.column < (columns - 1)
      new_cell = cells_board[cell.row - 1][cell.column + 1]
      neighbours << new_cell if new_cell.alive?
    end
    # north-west
    if cell.row > 0 && cell.column > 0
      new_cell = cells_board[cell.row - 1][cell.column - 1]
      neighbours << new_cell if new_cell.alive?
    end
    # south-east
    if cell.row < (rows - 1) && cell.column < (columns - 1)
      new_cell = cells_board[cell.row + 1][cell.column + 1]
      neighbours << new_cell if new_cell.alive?
    end
    # south-west
    if cell.row < (rows - 1) && cell.column > 0
      new_cell = cells_board[cell.row + 1][cell.column - 1]
      neighbours << new_cell if new_cell.alive?
    end
    neighbours
  end
end

# here the board and cells meet
class Round
  attr_accessor :board, :cells

  def initialize(board = Board, cells = [])
    @board = board
    @cells = cells

    cells.each do |cell|
      board.cells_board[cell[0]][cell[1]].alive = true
    end
  end

  def tick!
    dead_cells = []
    alive_cells = []
    @board.cells.each do |cell|
      if cell.alive? && board.neighbours(cell).count < 2
        cell.die!
      end
      if cell.alive? && board.neighbours(cell).count > 3
        cell.die!
      end
    end
  end
end
