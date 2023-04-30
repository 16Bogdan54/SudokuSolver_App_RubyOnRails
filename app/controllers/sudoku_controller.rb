class SudokuController < ApplicationController
  def index
    @sudoku = generate_board
  end

  def solve
    @sudoku = Sudoku.new(params[:board])
    @sudoku.solve
    render json: { solved_board: @sudoku.to_a }
  end

  private

  def generate_board
  end
end