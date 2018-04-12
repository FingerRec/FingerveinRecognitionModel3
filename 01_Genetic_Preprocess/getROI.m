function [ roiimg ] = getROI( img )
%GETROI getROI of the picture
%   Detailed explanation goes here
[height,width] = size(img);
if (size(img,3)==3)
    img = rgb2gray(img);
end
edgeimg = edge(img,'roberts');
%figure,imshow(edgeimg);
maxLength = zeros(1,2);
for i = 1 : height/2
    tmp = find(edgeimg(i,:)==1);
    if(tmp > 0) maxLength(1) = i,break;
   % length(tmp)
    end
end
for i = height:-1:fix(height/2+1)
    tmp = find(edgeimg(i,:)==1)
    if(tmp > 0) maxLength(2) = i,break;
   % length(tmp)
    end
end
roiimg = img(maxLength(1):maxLength(2),1:width);
end

