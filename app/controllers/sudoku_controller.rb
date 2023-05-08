class SudokuController < ApplicationController
  def index
    @solution = Array.new(9) { Array.new(9, 0) }
    @sudoku_solver = SudokuSolver.new
    @sudoku_validator = SudokuValidator.new
    if request.post?
      @sudoku = sudoku_params.values.map { |row| row.values.map(&:to_i) }
      if params.keys.include? 'solve'
        @solved_sudoku = @sudoku_solver.solve(@sudoku)
        if !@solved_sudoku
          @solution = @sudoku
          @cant_solve = true
        elsif @solved_sudoku
          @solution = @sudoku
        else
          @solution = @solved_sudoku
        end
      else
        @solution = @sudoku
        @is_solved = @sudoku_validator.solved?(@sudoku)
      end
    end
  end

  private

  def sudoku_params
    params.require(:sudoku).permit!
  end
end