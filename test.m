clc;
clear;
close all;

load('imgPack.mat');
personNum = 30;
showNum = 100;
showFlag = 36*(personNum-1);
for j = 1 : showNum
    showFlag = 36*(j-1)
    for i = 1:3
        subplot(2,3,i),imshow(imresize(imgPack(:,:,showFlag+i),[40,80]));
        subplot(2,3,i+3),imshow(imresize(imgPack(:,:,showFlag+i+3),[40,80]));
    end
    pause(5);
end

%% 
%{
clc;
clear;
close all;
load('trainRawData.mat');
load('imgPackNew.mat');
subplot(2,2,1),imshow(imresize(Origin(:,:,3),[40,80]));
subplot(2,2,3),imshow(imresize(imgPack(:,:,3),[40,80]));
subplot(2,2,2),imshow(imresize(Origin(:,:,4),[40,80]));
subplot(2,2,4),imshow(imresize(imgPack(:,:,4),[40,80]));
%}

%%
%{
load('imgPack.mat');
load('RawData.mat');
personNum = 30;
showFlag = 36*(personNum-1);
for i = 1:3
    subplot(2,3,i),imshow(imresize(Origin(:,:,showFlag+i),[40,80]));
    subplot(2,3,i+3),imshow(imresize(imgPack(:,:,showFlag+i),[40,80]));
end
%}
%% 
%img = imread('/Users/Documents/MATLAB/FingerVeinDatabase/040/left/index_1.bmp');
%figure;
%out = fingerDetection(img);
%imshow(out);