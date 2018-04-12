%convert picture from 320x240 to 40x80
path = '/Users/Documents/MATLAB/FingerVeinDatabase';
str = '';
imageWidth = 40;
imageHeight = 80;
imageNumber = 3600;
imageSize = imageWidth * imageHeight;
HistArray = zeros(imageSize,imageNumber);
Origin = zeros(imageWidth,imageHeight,imageNumber);
for i = 1:100
    fprintf('%d person have calculated origin and histArray.\n',i);
    if(i<10) 
        str = strcat('/00',num2str(i));
    elseif(i<99)
        str=strcat('/0',num2str(i));
    end
    ldir = dir([path,str,'/left/*.bmp']);
    for j = 1 : 18
         HistArray(:,(i-1)*36+j) = reshape((imresize(fingerDetection(imread([path,str,'/left/',ldir(j).name])),[40,80])),imageSize,1);
         HistArray(:,(i-1)*36+18+j) = reshape((imresize(fingerDetection(imread([path,str,'/right/',ldir(j).name])),[40,80])),imageSize,1);
         Origin(:,:,(i-1)*36+j) = reshape((imresize(fingerDetection(imread([path,str,'/left/',ldir(j).name])),[40,80])),imageWidth,imageHeight);
         Origin(:,:,(i-1)*36+18+j) = reshape((imresize(fingerDetection(imread([path,str,'/right/',ldir(j).name])),[40,80])),imageWidth,imageHeight);
    end
end
HistArray = HistArray/255;
Origin = Origin/255;
save -v7.3 trainRawData.mat Origin
save -v7.3 trainHistArray.mat  HistArray
