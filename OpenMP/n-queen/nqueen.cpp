
#include <time.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <omp.h>
#include <stdbool.h>

#define n 13

int board[30];
int ans = 0;
int N;

bool can(int r, int c, int b[]){
    for (int i = 1; i < r; i++){
        if(b[i] == c){
            return 0;
        }
        if(abs(b[i]-c) == r - i){
            return 0;
        }
    }
    return 1;
}

void vazir(int r, int c, int b[]){

    if(!can(r,c,b))
        return;
    b[r] = c;
    if(r == N){
        #pragma omp critical
        ans++;
        return;
    }
    for(int i=1; i<=N; i++) {
        vazir(r+1, i, b);
    }
}

void solve(){
    #pragma omp parallel for
    for(int i=1; i<=N; i++) {
        vazir(1, i, new int[30]);
    }
}

int main(int argc, char *argv[]){
    struct timeval startTime, stopTime;
    long totalTime;
    gettimeofday(&startTime, NULL);
    N = n;
    ans = 0;

    solve();

    gettimeofday(&stopTime, NULL);
    totalTime = (stopTime.tv_sec * 1000000 + stopTime.tv_usec) - (startTime.tv_sec * 1000000 + startTime.tv_usec);
    printf("N=%d total time=%ld ans=%d\n",N, totalTime, ans);

}

