clear all;
clc;
addpath(genpath('01_Genetic_Preprocess'));
addpath(genpath('02_Feature_Extraction'));
addpath(genpath('03_Convolution&Pooling'));
addpath(genpath('04_Classification&Test'));
addpath(genpath('FinalDatasets'));
addpath(genpath('minFunc'));
addpath(genpath('TestAndPrint'));
%%
%Read And Load Origin image to origin.mat 
%size:76800(240x320)x3600
%{
path = 'E:\Í¼Æ¬Êý¾Ý¿â\Finger Vein Database\Finger Vein Database';
str = '';
Origin = zeros(76800,3600);
for i = 1:100
    if(i<10) 
        str = strcat('\00',num2str(i));
    elseif(i<99)
        str=strcat('\0',num2str(i));
    end
    ldir = dir([path,str,'\left\*.bmp']);
    for j = 1 : 18
        %size(rgb2gray(imread([path,str,'\left\',ldir(j).name])))
         Origin(:,(i-1)*36+j) = reshape(rgb2gray(imread([path,str,'\left\',ldir(j).name])),76800,1);
         Origin(:,(i-1)*36+18+j) = reshape(rgb2gray(imread([path,str,'\right\',ldir(j).name])),76800,1);
    end
end
save -v7.3 origin.mat Origin
%}
%%
%display 144 pictures in origin.mat
%{
load('origin.mat');
m = 3600;
rand_indices = randperm(m);
sel = double(Origin(:,rand_indices(1:144))/256);
displayData(sel,320);
%}
%%
%display 100 random picture in imgPack.mat which is mapping data
%{
%X:5000x400 y:5000x1
load('imgPack.mat');
m = 3600;
rand_indices = randperm(m);
X = reshape(imgPack,3200,3600);
sel = X(:,rand_indices(1:144));
displayData(sel,80);
%}
%%
%display patches_size100_378000
%{
load('Patches_size100_378000.mat');
m = 378000;
rand_indices = randperm(m);
sel = patches(:,rand_indices(1:100));
displayData(sel,10);
%}
%%
%display patches_size100_378000
%{
load('TrainFeatures_H125_I100.mat');
m = 36000;
rand_indices = randperm(m);
showData = reshape(TrainFeatures,100,36000);
sel = showData(:,rand_indices(1:100));
displayData(sel,10);
%}

%% Visualize learned features
visibleSize=100;
hiddenSize=125;
load('DataFeatures_H125_I700.mat');
W = reshape(optTheta(1:visibleSize * hiddenSize), hiddenSize, visibleSize);
%b = optTheta(2*hiddenSize*visibleSize+1:2*hiddenSize*visibleSize+hiddenSize);
%displayColorNetwork( (W*ZCAWhite)');
display_network(W', 12); 
