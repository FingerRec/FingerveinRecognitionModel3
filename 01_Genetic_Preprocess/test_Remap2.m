clc;
clear;
close all;

load('RawData.mat');

result = Origin(:,:,1)
img = reshape(result,[40,80])
imshow(img)
