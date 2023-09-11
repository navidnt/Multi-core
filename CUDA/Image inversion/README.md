# Image Inversion using CUDA

This code demonstrates image inversion using CUDA (Compute Unified Device Architecture) to leverage GPU parallel processing. Image inversion involves changing the color of each pixel in an image to its complementary color.

## Prerequisites

Before running this code, make sure you have the following prerequisites set up:

- NVIDIA GPU with CUDA support.
- CUDA Toolkit installed.
- Input image data in the form of a text file ("imageMat2.txt" in this code).
- A C++ development environment.

## Code Overview

Here is a brief overview of the code:

1. **Kernel Function**: The core of this code is the `inverter` kernel function, which runs on the GPU. It takes an input image array `g_idata`, processes it by subtracting each pixel value from 255 to invert the colors, and stores the result in `g_odata`.

2. **Main Function**:
   - Reads the input image data from "imageMat2.txt" and stores it in the `ph_host` array.
   - Sets up CUDA events to measure execution time.
   - Allocates memory on the GPU for the input and output data using `cudaMalloc`.
   - Copies the input data from the host to the device using `cudaMemcpy`.
   - Calls the `inverter` kernel on the GPU.
   - Copies the inverted image data from the device to the host.
   - Measures the execution time of the kernel.
   - Writes the inverted image data to "imageMat3.txt".
   - Frees allocated memory on the GPU and host.

3. **File I/O**:
   - The code reads image data from "imageMat2.txt" and writes the inverted image data to "imageMat3.txt" as plain text.

4. **Error Handling**:
   - The code includes error checking for CUDA function calls using `cudaGetLastError()` to detect and report any GPU-related errors.
NOTE: You can convert your input image to .txt using readIm.cpp. You can also convert the imageMat3.txt to an image using writeIm.cpp.

## Results

| Input Image | Inversed Image |
|------------ | ------------- |
| ![image1.jpg](https://github.com/navidnt/Multi-core/blob/main/CUDA/Image%20inversion/photo1.jpg) | ![Image 2](https://github.com/navidnt/Multi-core/blob/main/CUDA/Image%20inversion/new_image.jpg) |
