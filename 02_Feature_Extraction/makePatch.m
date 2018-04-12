function [  ] = makePatch(  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   �õ�100(���ص����)x378000(����)���������
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
            %��40*80��ͼƬ��Ϊ10x10С��
            %x:1-10 6-15 11-20 16-25 ... 31-40
            %y:1-10 6-15 ................71-80
            window=imgPack(x:x+patchDim-1,y:y+patchDim-1,i);
            patches(1:100,k)=reshape(window(:,:,1)',100,1);
            %��Ϊ100x1���������Ҽ�¼Ϊ����k,�ܼ�378000������
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
%Ӧ��Ϊmean(patches,2)����ÿ��ͼ���ľ�ֵ
%��patches�ĵ�һά��ֵ����ÿ�������ľ�ֵ
meanPatch = mean(patches, 2); 
%minus:������  bsxfun;��������A��B���������Ķ�ֵ��������ȥ��ֵ����forѭ����Ч:
patches = bsxfun(@minus, patches, meanPatch);
% Apply ZCA whitening
%ZCA�׻��㷨 �� ��������תΪ������ص�����
sigma = patches * patches' / numPatches;
[u, s, v] = svd(sigma);%PCA������������,uΪ����������uΪ��������,sΪ�Խ�������ֵ,vΪu��
ZCAWhite = u * diag(1 ./ sqrt(diag(s) + epsilon)) * u';%�׻���ʽ������ZCAWhiteΪ�׻�����
patches = ZCAWhite * patches; %�׻��������
%�õ�zca�׻�����
save('FinalDatasets/Patches_size100_378000.mat', 'patches','-v7.3');
save('02_Feature_Extraction/DataFeatures/Mean_ZCA.mat', 'ZCAWhite', 'meanPatch');
%meanPatchΪ100x1��ֵ��ZCAWhiteΪ������İ׻�������������˼�Ϊ�׻�����
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