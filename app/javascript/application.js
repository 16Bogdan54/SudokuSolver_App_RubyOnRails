// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

const generateSudoku = () => {
    const grid = [
        [6, 5, 3, 1, 9, 2, 8, 7, 4],
        [1, 7, 4, 8, 6, 5, 3, 2, 9],
        [2, 9, 8, 7, 3, 4, 5, 6, 1],
        [8, 2, 5, 6, 7, 1, 9, 4, 3],
        [7, 1, 9, 5, 4, 3, 2, 8, 6],
        [4, 3, 6, 9, 2, 8, 7, 1, 5],
        [5, 6, 7, 2, 1, 9, 4, 3, 8],
        [9, 4, 1, 3, 8, 7, 6, 5, 2],
        [3, 8, 2, 4, 5, 6, 1, 9, 7]
    ];
    const resultGrid = [];

    for (let row = 0; row < 9; row++) {
        resultGrid.push([]);
        for (let col = 0; col < 9; col++) {
            const value = grid[row][col];
            const chance = Math.random();
            resultGrid[row][col] = chance < 0.5 ? 0 : value;
        }
    }

    return resultGrid;
}

document.addEventListener("DOMContentLoaded", () => {
    const randomizeButton = document.getElementById("randomize");
    const sudokuInputs = document.querySelectorAll(".sudoku-input");

    randomizeButton.addEventListener("click", () => {
        const sudoku = generateSudoku().flat();
        sudokuInputs.forEach((input, idx) => {
            input.value = sudoku[idx];
        });
    });
});