clc;
clear;
close all;
%{
% test plot
load('trainRawData.mat');

for i = 1:1
    figure;
    inputImg = reshape(Origin(:,:,i),[40,80]);
    imshow(inputImg);
    detectImg = getROI(inputImg);
    subplot(1,2,1)
    imshow(inputImg)
    subplot(1,2,2)
    imshow(detectImg)  
end
%}
%% plot 6 pictures

path = '/Users/Documents/MATLAB/FingerVeinDatabase';
str = '/017';
ldir = dir([path,str,'/left/*.bmp']);
for i = 1:1
    inputImg = imread([path,str,'/left/',ldir(i+6).name]);
    fingerImg = fingerDetection(inputImg);
    roiImg = getROI(fingerImg);
    figure;
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    subplot(1,3,1)
    imshow(inputImg)
    title('inputImg');
    subplot(1,3,2)
    imshow(fingerImg)  
    title('fingerImg');
    subplot(1,3,3)
    imshow(roiImg)
    title('roiImg');
end


%% a 
%{
inputImg = imread('/Users/Documents/MATLAB/FingerVeinDatabase/054/left/middle_5.bmp');
detectImg = fingerDetection(inputImg);
figure;imshow(detectImg);
%}