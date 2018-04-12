clc;
clear;
close all;

load 'trainhistArray.mat'
load 'trainRawData.mat'
load 'imageTestData.mat'
result = Origin(:,:,1400)
histresult = HistArray(:,1400)
img = reshape(HistArray(:,1400),[40,80])
img2 = reshape(testFeatures(:,5),[40,80])
imshow(img2)
