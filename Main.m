clear all;
clc;
addpath(genpath('02_Feature_Extraction'));
addpath(genpath('03_Convolution&Pooling'));
addpath(genpath('04_Classification&Test'));
addpath(genpath('FinalDatasets'));
addpath(genpath('minFunc'));
FE_Main;%feature extraction
CNN_Main;%cnn
CLASS_Main;
