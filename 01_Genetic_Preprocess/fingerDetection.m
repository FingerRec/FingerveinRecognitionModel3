function [res] = fingerDetection(img)
%240 x 320
%% sobel and contour
%get contour image
if size(img,3)==3
    grayimg = rgb2gray(img);
else
    grayimg = img;
end
[height,width] = size(grayimg);
edgeimg = edge(grayimg,'sobel');
%subplot(2,3,1),imshow(grayimg),title('原始图像');
%subplot(2,3,2),imshow(edgeimg),title('边缘图像');
%subplot(2,3,3),contourimg = imcontour(edgeimg);title('轮廓提取');
contourimg = contourc(double(edgeimg));
%% get label from contour
%get the contour matrix
%two matrix,record the two edge for finger_vein
%0.1 means the point number
length = 0;
count = 0;
lineminlength = 100;
imgshow = zeros(height,width);
for i = 1:size(contourimg,2)
    if(contourimg(1,i)==0.1 && contourimg(2,i)>lineminlength)
        if count == 0
            for j = 1:contourimg(2,i)
                imgshow(ceil(contourimg(2,i+j)),ceil(contourimg(1,i+j)))=255;
            end
            count = count + 1;
        else
            for j = 1:contourimg(2,i)
                imgshow(ceil(contourimg(2,i+j)),ceil(contourimg(1,i+j)))=255;
            end
        end
    end
end
%subplot(2,3,4),imshow(imgshow),title('二值图像');

%% remove the branch
%settring thresh_cross = 10;the max length
threshcross = 5;
for i = 1:width
    if (sum(imgshow(:,i))/255 > threshcross)  imgshow(:,i) = 0;
   %  elseif(sum(imgshow(:,i))/255>0) ;
    end
end
%subplot(2,3,5),imshow(imgshow),title('去除分支');
thinimg = bwmorph(imgshow,'thin',Inf);
%subplot(2,3,6),imshow(thinimg),title('细化');
%% extend the line 
%notice:thinimg is logical with 0 and 1
%left-up
%rotation angle
extendimg = thinimg;
sita = 10;
f = 0;
for i = height/2:-1:5
    for j = 5:width/2-1
        if(extendimg(i,j) == 1 )
            extendimg(i,1:j) = 1;
            f = i; break;
        end     
    end
    if(f~=0) 
        break; 
    end 
end
%left-down
f = 0;
for i = height-20:-1:height/2
    for j = 5:width/3-1
        if(countendpoint(i,j,extendimg)==1)
            if(extendimg(i,j)==1)
                extendimg(i,1:j) = 1;
                f = i; break;
            end
        end     
    end
    if(f~=0) 
        break; 
    end 
end
%right-up
f = 0;
for i = height/2:-1:5
    for j = width-1:-1:width/2+1
        if(countendpoint(i,j,extendimg)==1)
            if(extendimg(i,j)==1)
                for k = j:width
                    extendimg(ceil(i+tan(sita/360*2*pi)*(k-j)),k) = 1;
                end
                f = i; break;
            end
        end     
    end
    if(f~=0) 
        break; 
    end 
end
%right-down
f = 0;
for i = height/2+1:1:height-1
    for j = width-1:-1:width/2+1
        if(countendpoint(i,j,extendimg)==1)
            if(extendimg(i,j)==1)
                for k = j:width
                    extendimg(floor(i-tan(sita/360*2*pi)*(k-j)),k) = 1;
                end
                f = i; break;
            end
        end     
    end
    if(f~=0) 
        break; 
    end 
end
detectimg = zeros(height,width);
%% show detect area 
%figure,
%subplot(1,3,1),imshow(extendimg);title('延长');
k = 1:width; 
[x1,y1,var1] = find(extendimg(1:height/2,k)==1,320,'last');
[x2,y2,var2] = find(extendimg(height/2:height,k)==1,320,'first');
for t = 2:min(size(x2),size(x1))-1
    x1(t)=max([x1(t-1),x1(t),x1(t+1)]);
    x2(t)=min([x2(t-1),x2(t),x2(t+1)]);
    detectimg(x1(t):height/2+x2(t),t)=1;
end

contEdge = fix(min(size(x2),size(x1))-1);
maxUpperEdge = fix(min(size(x2),size(x1))-1);
for t = contEdge : 320
    detectimg(x1(fix(maxUpperEdge+1)):fix(height/2+x2(maxUpperEdge+1)),t)=1;
end

%fprintf('maxUpperEdge is %.2f\n',contEdge);
%detectimg(x1' :(height/2 +x2'),k) = 1;
%subplot(1,3,2),imshow(detectimg),title('提取区域');
%% finger dection from origin picture
for i = 1:height
    for j = 1:width
        res(i,j) = grayimg(i,j)*double(detectimg(i,j));
    end
end
%subplot(1,3,3),imshow(res),title('提取结果');