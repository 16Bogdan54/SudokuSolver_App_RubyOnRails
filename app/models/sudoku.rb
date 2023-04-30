class Sudoku
  def initialize(board)
    @board = board
  end

  def solve
    solve_board(0, 0)
  end

  private

  def solve_board(row, col)
    return true if row == 9

    if @board[row][col] != 0
      if col == 8
        solve_board(row + 1, 0)
      else
        solve_board(row, col + 1)
      end
    else
      (1..9).each do |num|
        if valid_move?(row, col, num)
          @board[row][col] = num

          if col == 8
            return true if solve_board(row + 1, 0)
          else
            return true if solve_board(row, col + 1)
          end
        end
      end

      @board[row][col] = 0
      return false
    end
  end

  def valid_move?(row, col, num)
    return false if @board[row].include?(num)

    return false if @board.transpose[col].include?(num)

    box_row = (row / 3) * 3
    box_col = (col / 3) * 3

    (box_row...box_row + 3).each do |r|
      (box_col...box_col + 3).each do |c|
        return false if @board[r][c] == num
      end
    end

    true
  end
end
