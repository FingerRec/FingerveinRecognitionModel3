function [ val ] = H_Value( i, j, img )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
val=img(i+1,j-1)+2*img(i+1,j)+img(i+1,j+1)-img(i-1,j-1)-2*img(i-1,j)-img(i-1,j+1);
val=val^2;

end

