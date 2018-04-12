%{
load('RawData.mat');
load('imgPackNew.mat');
%figure;
%img = imread('/Users/Desktop/u2.bmp');
%img = imresize(Origin(:,:,15),[40,80]);
%imshow(imgPack(:,:,1));
img = Origin(:,:,1);
%Origin(:,:,1) = img(7:25,1:80);
%imshow(Origin(:,:,1));
img = img(10:30,1:80);
img = imresize(img,[40,80]);
Origin(:,:,1) = img;
imshow(Origin(:,:,1));
%}
img = imread('/Users/Documents/MATLAB/FingerVeinDatabase/077/left/index_2.bmp');
img2 = getROI(rgb2gray(img));
figure;
imshow(img2);
%load('RawData.mat');
%load('imgPackNew.mat');
%i = 1400;
%subplot(1,2,1),imshow(imgPack(:,:,i));
%subplot(1,2,2),imshow(Origin(:,:,i));