# Parallelized Jacobi Algorithm with OpenMP

This is a parallelized implementation of the Jacobi algorithm for solving the heat diffusion equation using OpenMP. The program distributes the computation across multiple threads, improving execution speed on multi-core processors.

## Introduction

The Jacobi algorithm is used to solve partial differential equations, particularly the heat diffusion equation. This version of the algorithm leverages OpenMP to parallelize the computation, making it more efficient.

## Prerequisites

To compile and run this code, you need:

- A C compiler with OpenMP support (e.g., GCC)
- A system with multiple CPU cores for parallel execution

## Algorithm Overview

1. Initialize the temperature grid and set boundary conditions.
2. Perform the Jacobi iterations until convergence:
   - Compute new temperature values for each grid point.
   - Update the grid with the new values.
   - Calculate the maximum temperature difference between old and new values.
3. Parallelize the computation using OpenMP to distribute work across multiple threads.

## Performance

This implementation includes parallel sections and parallel for-loops using OpenMP to distribute the computation across threads. Performance can be further optimized by adjusting the number of threads used (num_threads) in the OpenMP directives. Keep in mind that parallelism may not always result in linear speedup due to overhead and thread synchronization. Experiment with different grid sizes and thread counts to find the best performance for your hardware. Here you can see the results on my machine.  
![Results](https://github.com/navidnt/Multi-core/blob/main/OpenMP/jacobi/results_jacobi/results.jpg)
