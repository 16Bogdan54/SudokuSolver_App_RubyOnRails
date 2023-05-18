class SudokuSolver
  def self.solve(grid)
    @grid = grid
    find = find_empty_cell(@grid)
    return true unless find

    row, col = find

    (1..9).each do |num|
      if valid?(row, col, num)
        @grid[row][col] = num

        return @grid if solve(@grid)

        @grid[row][col] = 0
      end
    end

    false
  end

  def self.find_empty_cell(grid)
    grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        return [i, j] if cell.zero?
      end
    end

    nil
  end

  def self.valid?(row, col, num)
    (0..8).each do |i|
      return false if @grid[row][i] == num
      return false if @grid[i][col] == num
    end

    box_row = (row / 3) * 3
    box_col = (col / 3) * 3

    (0..2).each do |i|
      (0..2).each do |j|
        return false if @grid[box_row + i][box_col + j] == num
      end
    end

    true
  end
end