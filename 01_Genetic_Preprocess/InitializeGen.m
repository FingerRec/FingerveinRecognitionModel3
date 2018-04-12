function [ gen ] = InitializeGen( num, s )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%   random chromosome structure
gen=zeros(s,num);
%   s * num  matrix
for i=1:num
    gen(:,i)=sort(ceil(rand(s,1)*255));
end

end

