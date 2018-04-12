function [ X ] = NormalizeData( img )
%NORMALIZEDATA Summary of this function goes here
%   Detailed explanation goes here
X = img;
X = double(X);
X = X-mean(X(:));
X = X/std(X(:), 0, 1);

end

