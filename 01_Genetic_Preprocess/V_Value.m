function [ val ] = V_Value( i, j, img )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
val=img(i-1,j+1)+2*img(i,j+1)+img(i+1,j+1)-img(i-1,j-1)-2*img(i,j-1)-img(i+1,j-1);
val=val^2;
end

