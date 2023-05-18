class SudokuController < ApplicationController
  def index
    @solution = Array.new(9) { Array.new(9, 0) }
    if request.post?
      @sudoku = params[:sudoku].to_unsafe_h.values.map { |row| row.values.map(&:to_i) }
      if params.keys.include? 'solve'
        @solved_sudoku = SudokuSolver.solve(@sudoku)
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
        @is_solved = SudokuValidator.solved?(@sudoku)
      end
    end
  end

  def sudoku_params
    params.require(:sudoku).permit!
  end
end