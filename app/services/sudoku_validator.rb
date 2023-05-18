class SudokuValidator
  def self.solved?(grid)
    (0..8).each do |row|
      return false unless valid_group?(grid[row])
    end

    (0..8).each do |col|
      return false unless valid_group?(grid.map { |row| row[col] })
    end

    (0..2).each do |box_row|
      (0..2).each do |box_col|
        box = []
        (0..2).each do |row|
          (0..2).each do |col|
            box << grid[box_row * 3 + row][box_col * 3 + col]
          end
        end
        return false unless valid_group?(box)
      end
    end

    true
  end

  def self.valid_group?(group)
    group.sort == (1..9).to_a
  end
end