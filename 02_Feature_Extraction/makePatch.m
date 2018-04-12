function [  ] = makePatch(  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   得到100(像素点个数)x378000(块数)的输入矩阵
patchDim   = 10;
numPatches = 378000; %105*3600
epsilon = 0.1;
load('imgPack.mat');
patches=zeros(100,numPatches);
k=1;
for i = 1:3600
    for x = 1:5:31 
        for y = 1:5:71
            %7 * 15 = 105;
            %把40*80的图片分为10x10小块
            %x:1-10 6-15 11-20 16-25 ... 31-40
            %y:1-10 6-15 ................71-80
            window=imgPack(x:x+patchDim-1,y:y+patchDim-1,i);
            patches(1:100,k)=reshape(window(:,:,1)',100,1);
            %变为100x1的向量，且记录为向量k,总计378000个向量
            %imshow(patches(1:100,k));
            k=k+1;
        end
    end
%     for j=1:25
%         pos=randi(50-patchDim+1,2,1);
%         window=unlabeledImages(pos(1):pos(1)+patchDim-1,pos(2):pos(2)+patchDim-1,:,i);
%         patches(1:100,k)=reshape(window(:,:,1)',100,1);
%         patches(101:200,k)=reshape(window(:,:,2)',100,1);
%         k=k+1;
%     end
end
patches = normalizeData(patches);
%应该为mean(patches,2)计算每个图像块的均值
%求patches的第一维均值，即每个向量的均值
meanPatch = mean(patches, 2); 
%minus:减操作  bsxfun;两个数组A和B间逐个计算的二值操作，减去均值，比for循环高效:
patches = bsxfun(@minus, patches, meanPatch);
% Apply ZCA whitening
%ZCA白化算法 ； 冗余输入转为较少相关的数据
sigma = patches * patches' / numPatches;
[u, s, v] = svd(sigma);%PCA计算特征向量,u为特征向量，u为特征向量,s为对角线特征值,v为u的
ZCAWhite = u * diag(1 ./ sqrt(diag(s) + epsilon)) * u';%白化公式，其中ZCAWhite为白化矩阵
patches = ZCAWhite * patches; %白化后的数据
%得到zca白化数据
save('FinalDatasets/Patches_size100_378000.mat', 'patches','-v7.3');
save('02_Feature_Extraction/DataFeatures/Mean_ZCA.mat', 'ZCAWhite', 'meanPatch');
%meanPatch为100x1均值，ZCAWhite为计算出的白化矩阵，与数据相乘即为白化矩阵
end


%%
function patches = normalizeData(patches)

% Squash data to [0.1, 0.9] since we use sigmoid as the activation
% function in the output layer

% Remove DC (mean of images). 
patches = bsxfun(@minus, patches, mean(patches));

% Truncate to +/-3 standard deviations and scale to -1 to 1
pstd = 3 * std(patches(:));
patches = max(min(patches, pstd), -pstd) / pstd;

% Rescale from [-1,1] to [0.1,0.9]
patches = (patches + 1) * 0.4 + 0.1;

end