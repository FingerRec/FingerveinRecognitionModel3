clc;
warning on;
load('trainFinalChromo some.mat');
load('trainRawData.mat');
imageNumber=3600;

for i=1:imageNumber
    img=Origin(:,:,i)*255;
    hstg=GetHist(img);
    for j=1:size(finalChr,2)
        if size(finalChr{j},1)==size(hstg,1)
           Origin(:,:,i)=RemapHist(img,hstg,finalChr{j})/255;
        end
    end
end

save('trainImgPackNew','Origin');
