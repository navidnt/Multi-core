#include "opencv2/highgui.hpp"
#include "opencv2/imgproc.hpp"
#include "opencv2/core.hpp"
#include "opencv2/opencv.hpp"


#include <iostream>
#include <fstream>

using namespace cv;
using namespace std;


int main(int argv, char** argc){
    Mat testColor = imread("photo1.jpg", IMREAD_COLOR);
    ofstream im ("imageMat2.txt");
    //im << testColor;
    uint8_t* mp = &testColor.at<uint8_t> (0);
    for(int i = 0; i < 99532800; i++){
        im << int (mp[i]) << "\n";
    }
    im.close();

    //im << (int)mp[0] << "\n";
}
