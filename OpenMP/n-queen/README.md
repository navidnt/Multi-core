# N-Queens Problem Parallelization using OpenMP

This repository contains a C program that solves the N-Queens problem using parallelization with OpenMP. The N-Queens problem is a classic puzzle where you must place N chess queens on an N×N chessboard in a way that no two queens threaten each other. This program demonstrates the use of OpenMP for parallelizing the search for solutions to the N-Queens problem.

## Program Structure

- `n_queens.c` contains the main program logic.
- `can` function checks if it's safe to place a queen at a given position.
- `vazir` function recursively tries to place queens on the board.
- The `solve` function parallelizes the search for solutions using OpenMP.
- The program measures the total execution time using `gettimeofday` and prints the results.

## Performance Considerations

The code uses OpenMP to parallelize the search for solutions to the N-Queens problem. Depending on your hardware and the value of `N`, you may observe varying levels of speedup when running the program on different systems.


