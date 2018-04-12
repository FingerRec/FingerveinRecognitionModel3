clc;
clear;
close all;

load('trainRawData.mat');
personNum = 24;
showFlag = 36*(personNum-1);
for i = 1:3
    subplot(1,3,i),imshow(imresize(Origin(:,:,showFlag+i),[40,80]));
end

%img = imread('/Users/Documents/MATLAB/FingerVeinDatabase/040/left/index_1.bmp');
%figure;
%out = fingerDetection(img);
%imshow(out);