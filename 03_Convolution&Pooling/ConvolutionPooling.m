function [ TrainFeatures ] = ConvolutionPooling( itr,hid,name )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
imageChannels = 1;     % number of channels (rgb, so 3)

patchDim = 10;          % patch dimension

visibleSize = patchDim * patchDim * imageChannels;  % number of input units 
hiddenSize = hid;           % number of hidden units 

poolDim = 15;          % dimension of pooling region

load (name);
load (sprintf('02_Feature_Extraction/DataFeatures/DataFeatures_H%d_I%d.mat',hid,itr*100));
% --------------------------------------------------------------------

% Display and check to see that the features look good
W = reshape(optTheta(1:visibleSize * hiddenSize), hiddenSize, visibleSize);
b =  optTheta(2*hiddenSize*visibleSize+1:2*hiddenSize*visibleSize+hiddenSize);

%displayColorNetwork( (W*ZCAWhite)');

numTrainImages=size(imgPack,3);

%�����w,bΪѵ���õ������ز�
convolvedFeatures = cnnConvolve(patchDim, hiddenSize, imgPack, W, b, ZCAWhite, meanPatch);
%�ػ�
pooledFeatures = cnnPool(poolDim, convolvedFeatures);
%��������ά������1-3-4-2
%ѵ���õ���������ÿ��ͼƬ1000������
tmp = permute(pooledFeatures, [1 3 4 2]);
%���¹������
TrainFeatures = reshape(tmp, numel(pooledFeatures) / numTrainImages,...
    numTrainImages);

end

