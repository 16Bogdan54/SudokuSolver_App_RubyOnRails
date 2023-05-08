class SudokuValidator
  def solved?(grid)
    (0..8).each { |row|
      unless valid_group?(grid[row])
        return false
      end
    }

    (0..8).each { |col|
      unless valid_group?(grid.map { |row| row[col] })
        return false
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
          return false
        end
      }
    }

    true
  end

  def valid_group?(group)
    group.sort == (1..9).to_a
  end
end