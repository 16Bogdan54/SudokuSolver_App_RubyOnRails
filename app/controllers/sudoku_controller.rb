class SudokuController < ApplicationController
  def index
    @solution = Array.new(9) { Array.new(9, 0) }
    if request.post?
      @sudoku = params[:sudoku].to_unsafe_h.values.map { |row| row.values.map(&:to_i) }
      if params.keys.include? 'solve'
        @solved_sudoku = solve_sudoku(@sudoku)
        if !@solved_sudoku
          @solution = @sudoku
          @cantSolve = true
        elsif @solved_sudoku == true
          @solution = @sudoku
        else
          @solution = @solved_sudoku
        end
      else
        @solution = @sudoku
        @isSolved = sudoku_solved?(@sudoku)
      end
    end
  end

  private

  def solve_sudoku(grid)
    find = find_empty_cell(grid)
    return true unless find

    row, col = find

    (1..9).each do |num|
      if valid?(grid, row, col, num)
        grid[row][col] = num

        if solve_sudoku(grid)
          return grid
        end
        grid[row][col] = 0
      end
    end

    false
  end

  def find_empty_cell(grid)
    grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        if cell == 0
          return [i, j]
        end
      end
    end
    nil
  end

  def valid?(grid, row, col, num)
    (0..8).each { |i|
      if grid[row][i] == num
        return false
      end
    }

    (0..8).each { |i|
      if grid[i][col] == num
        return false
      end
    }

    box_row = (row / 3) * 3
    box_col = (col / 3) * 3
    (0..2).each { |i|
      (0..2).each { |j|
        if grid[box_row + i][box_col + j] == num
          return false
        end
      }
    }

    true
  end

  def sudoku_solved?(grid)
    (0..8).each { |row|
      unless valid_group?(grid[row])
        return 0
      end
    }

    (0..8).each { |col|
      unless valid_group?(grid.map { |row| row[col] })
        return 0
      end
    }

    (0..2).each { |box_row|
      (0..2).each { |box_col|
        box = []
        (0..2).each { |row|
          (0..2).each { |col|
            box << grid[box_row * 3 + row][box_col * 3 + col]
          }
        }
        unless valid_group?(box)
          return 0
        end
      }
    }

    1
  end

  def valid_group?(group)
    group.sort == (1..9).to_a
  end
end