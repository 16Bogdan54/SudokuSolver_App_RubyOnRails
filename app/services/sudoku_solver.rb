class SudokuSolver
  def self.solve(grid)
    @grid = grid
    find = find_empty_cell(@grid)
    return true unless find

    row, col = find

    (1..9).each do |num|
      if valid?(@grid, row, col, num)
        @grid[row][col] = num

        if solve(@grid)
          return @grid
        end
        @grid[row][col] = 0
      end
    end

    false
  end

  def self.find_empty_cell(grid)
    grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        if cell == 0
          return [i, j]
        end
      end
    end
    nil
  end

  def self.valid?(grid, row, col, num)
    (0..8).each do |i|
      if grid[row][i] == num
        return false
      end
    end

    (0..8).each do |i|
      if grid[i][col] == num
        return false
      end
    end

    box_row = (row / 3) * 3
    box_col = (col / 3) * 3
    (0..2).each do |i|
      (0..2).each do |j|
        if grid[box_row + i][box_col + j] == num
          return false
        end
      end
    end

    true
  end
end