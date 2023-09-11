# CUDA Jacobi Algorithm

## Overview

This repository contains a CUDA implementation of the Jacobi algorithm, a numerical method used to solve partial differential equations (PDEs) iteratively. The code parallelizes the Jacobi algorithm using NVIDIA CUDA, which enables it to run efficiently on GPU devices.

## Prerequisites

Before running the code, you'll need the following prerequisites:

- NVIDIA GPU with CUDA support
- CUDA Toolkit installed
- C++ Compiler (e.g., g++)
- Make sure to adjust the `Max_Size` and `Block_Size` constants to suit your hardware and problem size.

## Code Structure

- `jacobi_cuda.cu`: The main CUDA Jacobi algorithm implementation.
- `operate` kernel: The CUDA kernel responsible for performing the Jacobi iteration step in parallel.
- The code initializes a temperature grid, applies boundary conditions, and iteratively updates temperature values until convergence.

## Output

The program will print the number of iterations required for convergence, the execution time in milliseconds, and the maximum temperature difference between iterations.

## Performance Considerations

- Adjust the `Max_Size` and `Block_Size` constants to optimize the code for your specific GPU and problem size.
- Be mindful of the hardware limitations, especially when working with large grids.

Feel free to reach out with any questions or suggestions!
