class SudokuController < ApplicationController
  def index
    @solution = Array.new(9) { Array.new(9, 0) }
    if request.post?
      @sudoku = parse_sudoku_params(params[:sudoku])

      if params.key?('solve')
        @solved_sudoku = SudokuSolver.solve(@sudoku)

        if @solved_sudoku
          @solution = @solved_sudoku
        else
          @solution = @sudoku
          @cant_solve = true
        end

      else
        @solution = @sudoku
        @is_solved = SudokuValidator.solved?(@sudoku)
      end

    end
  end

  private

  def parse_sudoku_params(sudoku_params)
    sudoku_params.to_unsafe_h.values.map { |row| row.values.map(&:to_i) }
  end
end