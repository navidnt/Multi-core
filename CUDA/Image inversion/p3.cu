#include <iostream>
#include <stdio.h>
#include <fstream>
//#include <opencv/core.hpp>
#define Max_Size 99532800
#define Block_Size 16

using namespace std;





__global__ void inverter(int* g_idata, int* g_odata, int n){
    int tid = threadIdx.x;
    //g_odata[tid] = g_idata[tid];
    int st = tid * 1092 * 64;
    int ed = st + 1092 * 64;
    for(int i = st; i < ed; i++){
        g_odata[i] = 255 - g_idata[i];
        __syncthreads();
    }
}





//int ph[5000][8000][3];

int main(){
    int cnt = 0;
    int cntRow = 0;
    int cntCol = 0;
    int cntC = 0;
    ifstream inFile;
    ofstream outFile;
    inFile.open("imageMat2.txt");
    outFile.open("imageMat3.txt");
    int *ph_host = new int [Max_Size];
    while(cnt < 7680*4320*3){
        int z;
        inFile >> z;
        //ph[cntRow][cntCol][cntC] = z;
        ph_host[cnt] = z;
        cnt++;
        //outFile << ph[cntRow][cntCol][cntC] << "\n";
        /*if(cntC < 2){
            cntC++;
            continue;
        }
        cntC = 0;
        cntCol ++;
        if(cntCol == 7680){
            cntCol = 0;
            cntRow++;
        }*/
    }

    ///Device var define
    cudaEvent_t start, stop;
    cudaEventCreate (&start);
    cudaEventCreate (&stop);
    int* ph_dev;
    int* nph_dev;
    int* nph_host = new int [Max_Size];
    int SizeOfMax = Max_Size * sizeof(int);
    cudaMalloc((void **) &ph_dev, SizeOfMax);
    cudaMalloc((void **) &nph_dev, SizeOfMax);

    cudaMemcpy((void *)ph_dev, ph_host, SizeOfMax, cudaMemcpyHostToDevice);

    cudaEventRecord(start);

    inverter <<<1, Block_Size>>> (ph_dev, nph_dev, Max_Size);

    cudaEventRecord(stop);
    cudaDeviceSynchronize();
    cudaError_t error = cudaGetLastError();
            if(error!=cudaSuccess)
            {
              fprintf(stderr,"ERROR: %s\n", cudaGetErrorString(error) );
              exit(-1);
            }
    cudaMemcpy((void *) nph_host, nph_dev, SizeOfMax, cudaMemcpyDeviceToHost);

    float ms = 0;
    cudaEventElapsedTime(&ms, start, stop);

    cout << nph_host[0] << endl << ms << " ms" << endl << sizeof(float) << endl;

    for(int i = 0; i < Max_Size; i++){
        outFile << nph_host[i] << "\n";
    }

    outFile.close();
    inFile.close();

    cudaFree(ph_dev);
    cudaFree(nph_dev);
    free(ph_host);
    free(nph_host);
    return 0;
}
