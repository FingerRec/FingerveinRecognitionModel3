function [ optTheta ] = linearDecoder( hidden, iter , theta)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%linear decoder
%% CS294A/CS294W Linear Decoder Exercise

%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the
%  linear decoder exericse. For this exercise, you will only need to modify
%  the code in sparseAutoencoderLinearCost.m. You will not need to modify
%  any code in this file.

%%======================================================================
%% STEP 0: Initialization
%  Here we initialize some parameters used for the exercise.

imageChannels = 1;     % number of channels (rgb, so 3)

patchDim   = 10;          % patch dimension
numPatches = 378000;   % number of patches

visibleSize = patchDim * patchDim * imageChannels;  % number of input units 
outputSize  = visibleSize;   % number of output units
hiddenSize  = hidden;           % number of hidden units 

%maybe 0.001
sparsityParam = 0.035; % desired average activation of the hidden units.
lambda = 3e-3;         % weight decay parameter       
beta = 5;              % weight of sparsity penalty term       

epsilon = 0.1;	       % epsilon for ZCA whitening

%%======================================================================
%% STEP 2: Learn features on small patches
%  In this step, you will use your sparse autoencoder (which now uses a 
%  linear decoder) to learn features on small patches sampled from related
%  images.

%% STEP 2a: Load patches
%  In this step, we load 100k patches sampled from the STL10 dataset and
%  visualize them. Note that these patches have been scaled to [0,1]

%load unlabeledImages;
% load('ATVS_17500_size50.mat');
% patches=zeros(200,1120000);
% k=1;
% for i=1:17500
%     for x=1:5:40
%         for y=1:5:40
%             window=unlabeledImages(x:x+patchDim-1,y:y+patchDim-1,:,i);
%             patches(1:100,k)=reshape(window(:,:,1)',100,1);
%         	patches(101:200,k)=reshape(window(:,:,2)',100,1);
%             k=k+1;
%         end
%     end
% %     for j=1:25
% %         pos=randi(50-patchDim+1,2,1);
% %         window=unlabeledImages(pos(1):pos(1)+patchDim-1,pos(2):pos(2)+patchDim-1,:,i);
% %         patches(1:100,k)=reshape(window(:,:,1)',100,1);
% %         patches(101:200,k)=reshape(window(:,:,2)',100,1);
% %         k=k+1;
% %     end
% end

%displayColorNetwork(patches(:, 1:100));

%% STEP 2b: Apply preprocessing
%  In this sub-step, we preprocess the sampled patches, in particular, 
%  ZCA whitening them. 
% 
%  In a later exercise on convolution and pooling, you will need to replicate 
%  exactly the preprocessing steps you apply to these patches before 
%  using the autoencoder to learn features on them. Hence, we will save the
%  ZCA whitening and mean image matrices together with the learned features
%  later on.

% Subtract mean patch (hence zeroing the mean of the patches)
% meanPatch = mean(patches, 2);  
% patches = bsxfun(@minus, patches, meanPatch);
% 
% % Apply ZCA whitening
% sigma = patches * patches' / numPatches;
% [u, s, v] = svd(sigma);
% ZCAWhite = u * diag(1 ./ sqrt(diag(s) + epsilon)) * u';
% patches = ZCAWhite * patches;
% save('Patches_size200_1750000.mat', 'patches','-v7.3');
%displayColorNetwork(patches(:, 1:100));

%% STEP 2c: Learn features
%  You will now use your sparse autoencoder (with linear decoder) to learn
%  features on the preprocessed patches. This should take around 45 minutes.

% theta = initializeParameters(hiddenSize, visibleSize);
load('Mean_ZCA.mat');
load('Patches_size100_378000.mat');
% Use minFunc to minimize the function
addpath minFunc/
%lbfgs method
%iteration:100-300...-700
options = struct;
options.Method = 'lbfgs'; 
options.maxIter = iter*100;
options.display = 'on';

%learning feature from encode
%minFunc- lbfgs
[optTheta, cost] = minFunc( @(p) sparseAutoencoderLinearCost(p, ...
                                   visibleSize, hiddenSize, ...
                                   lambda, sparsityParam, ...
                                   beta, patches), ...
                              theta, options);

                          % Save the learned features and the preprocessing matrices for use in 
% the later exercise on convolution and pooling
fprintf('Saving learned features and preprocessing matrices...\n');                          
save(sprintf('02_Feature_Extraction/DataFeatures/DataFeatures_H%d_I%d.mat',hidden,iter*100), 'optTheta', 'ZCAWhite', 'meanPatch');
fprintf('Saved\n');
%learned feature for cooling and pooling
%????????????????????????
%% STEP 2d: Visualize learned features
%display the hidden layer 
%W = reshape(optTheta(1:visibleSize * hiddenSize), hiddenSize, visibleSize);
%b = optTheta(2*hiddenSize*visibleSize+1:2*hiddenSize*visibleSize+hiddenSize);
%displayColorNetwork( (W*ZCAWhite)');
%display_network(W', 10); 

end

