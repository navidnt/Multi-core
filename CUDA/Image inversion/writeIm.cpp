#include "opencv2/highgui.hpp"
#include "opencv2/imgproc.hpp"
#include "opencv2/core.hpp"
#include "opencv2/opencv.hpp"


#include <iostream>
#include <fstream>

using namespace cv;
using namespace std;


uint8_t ph[4320][7680][3];
int cnt = 0;
int cntRow = 0;
int cntCol = 0;
int cntC = 0;


int main(int argv, char** argc){
    /*Mat testColor = imread("photo1.jpg", IMREAD_COLOR);
    ofstream im ("imageMat2.txt");
    //im << testColor;
    uint8_t* mp = &testColor.at<uint8_t> (0);
    for(int i = 0; i < 99532800; i++){
        im << (int) mp[i] << "\n";
    }
    im.close();
    //im << (int)mp[0] << "\n";*/
    Mat testColor = imread("photo1.jpg", IMREAD_COLOR);
    ifstream im;
    im.open("imageMat3.txt");
    while(cnt < 7680*4320*3){
        int z;
        im >> z;
        ph[cntRow][cntCol][cntC] = uint8_t (z);
        cnt++;
        /*int x = int (ph[cntRow][cntCol][cntC]);
        x = 255 - x;
        ph[cntRow][cntCol][cntC] = uint8_t(x);*/
        if(cntC < 2){
            cntC++;
            continue;
        }
        cntC = 0;
        cntCol ++;
        if(cntCol == 7680){
            cntCol = 0;
            cntRow++;
        }
    }
    im.close();
    Mat newIm(4320, 7680, 16, ph);
    //cout << newIm.row(0).col(2) << endl << int(ph[0][0][0]);
    imwrite("new_image.jpg", newIm);

    uint8_t* mp = &testColor.at<uint8_t> (0);
    uint8_t* mp1 = &newIm.at<uint8_t> (0);
    for(int i = 0; i < 99532800; i++){
        if(mp1[i] != mp[i]){
            cout << i << endl;
            cout << int (mp[i]) << " " << int (mp1[i]);
            break;
        }
    }

    /*for(int i = 0; i < 4320; i++){
        if(newIm.row(i).col(2) != testColor.row(i).col(2)){
            cout << i << endl;
        }
    }*/

}
