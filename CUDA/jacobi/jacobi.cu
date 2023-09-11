#include <iostream>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <time.h>
#include <omp.h>


#define Max_Size 128
#define Block_Size 32

using namespace std;


__global__ void operate(double* g_i, double* g_o, int wid){
    int rowSt =  threadIdx.y * Max_Size/Block_Size;
    int colSt =  threadIdx.x * Max_Size/Block_Size;
    int rowEd = (threadIdx.y + 1) * Max_Size/Block_Size;
    int colEd = (threadIdx.x + 1) * Max_Size/Block_Size;
    double sum = 0;
    for(int row = rowSt; row < rowEd; row++){
      for(int col = colSt; col < colEd; col++){
        if(row > 0 && row < Max_Size-1 && col > 0 && col < Max_Size-1){
          sum += g_i[row*wid+col-1];
          sum += g_i[row*wid+col-wid];
          sum += g_i[row*wid+col+1];
          sum += g_i[row*wid+col+wid];
          g_o[row*wid+col] = double (sum/4);
          sum = 0;
        }
        else{
          g_o[row*wid+col] = g_i[row*wid+col];
        }
      }
    }
}



int main(int argc, char *argv[]) {

    //struct timeval startTime, stopTime;

    int m;
    int n;
    double tol; // = 0.0001;
    //long totalTime;

    m = atoi(argv[1]);
    n = atoi(argv[2]);
    tol = atof(argv[3]);
    float ms;
    //double t[m + 2][n + 2], tnew[m + 1][n + 1], diff, diffmax;
    double *t_host = new double[Max_Size*Max_Size];
    double *tnew_host = new double[Max_Size*Max_Size];
    double diff, diffmax;
    //for (int z = 0; z < 11; z++) {
        //gettimeofday(&startTime, NULL);


        // initialise temperature array
        for (int i = 0; i < m + 2; i++){
            for (int j = 0; j < n + 2; j++){
                t_host[i*(n+2)+j] = 30.0;
                //printf("%d %d thread: %d\n", i, j, omp_get_thread_num());
            }
        }


        {
            // fix boundary conditions
            for (int i = 1; i <= m; i++) {
                t_host[i*(n+2)] = 10.0;
                t_host[(i+1)*(n + 1)+i] = 140.0;
            }
            for (int j = 1; j <= n; j++) {
                t_host[j] = 20.0;
                t_host[(m + 1)*(n+2)+j] = 100.0;
            }
        }

        // main loop
        diffmax = 1000000.0;
        int lev = 0;
        while (diffmax > tol) {
            lev++;
            // update temperature for next iteration
            /*for (int i = 1; i <= m; i++)
                for (int j = 1; j <= n; j++)
                    tnew[i][j] =
                        (t[i - 1][j] + t[i + 1][j] + t[i][j - 1] + t[i][j + 1]) / 4.0;
            */
            //cout << tnew_host[0] << " Hello\n";
            cudaEvent_t start, stop;
            cudaEventCreate (&start);
            cudaEventCreate (&stop);
            double *t_dev, *tnew_dev;
            int SizeOfMax = Max_Size * Max_Size * sizeof(double);
            cudaMalloc((void **) &t_dev, SizeOfMax);
            cudaMalloc((void **) &tnew_dev, SizeOfMax);
            cudaMemcpy(t_dev, t_host, SizeOfMax, cudaMemcpyHostToDevice);
            //int ggg = (Max_Size-1)/Block_Size+1;
            //cout << " SFASF " << ggg << endl;
            //dim3 dimGrid(ggg,ggg);
            dim3 dimBlock(Block_Size,Block_Size);
            cudaEventRecord(start);
            operate <<<1, dimBlock>>> (t_dev, tnew_dev, Max_Size);
            cudaEventRecord(stop);
            cudaDeviceSynchronize();
            cudaError_t error = cudaGetLastError();
            if(error!=cudaSuccess)
            {
              fprintf(stderr,"ERROR: %s\n", cudaGetErrorString(error) );
              exit(-1);
            }
            cudaMemcpy(tnew_host, tnew_dev, SizeOfMax, cudaMemcpyDeviceToHost);
            ms = 0;
            cudaEventElapsedTime(&ms, start, stop);
            diffmax = 0.0;
            // work out maximum difference between old and new temperatures
            for (int i = 1; i <= m; i++) {
                for (int j = 1; j <= n; j++) {
                  diff = fabs(tnew_host[i*(n+2)+j] - t_host[i*(n+2)+j]);
                  if(diff > diffmax) {
                    diffmax = diff;
                  }
                  // copy new to old temperatures
                  t_host[i*(n+2)+j] = tnew_host[i*(n+2)+j];
                }
            }
            //cout << "sss " << tnew_host[344] << endl;
            cudaFree(t_dev);
            cudaFree(tnew_dev);
        }

        //gettimeofday(&stopTime, NULL);
        //totalTime = (stopTime.tv_sec * 1000000 + stopTime.tv_usec) -
           //         (startTime.tv_sec * 1000000 + startTime.tv_usec);

        //printf("%ld\n", totalTime);
        cout << lev << " ms:" << ms << " " << diffmax << endl;
    //}
}


