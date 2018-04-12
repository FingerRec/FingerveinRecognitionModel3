function [ top, otherGen, otherFitt ] = Elitism( gen, fitt, prob )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
s=size(gen,1);
elite=ceil(size(gen,2)*prob);
if rem(size(gen,2)-elite,2)>0
    elite=elite+1;
end
top=zeros(s,elite);
for i=1:elite
    arry=find(fitt==max(fitt));
    idx=arry(end);
    top(:,i)=gen(:,idx);
    fitt(idx)=fitt(idx)+1;
    t= fitt==max(fitt);
    t=~t;
    gen=gen(:,t);
    fitt=fitt(t);
end
otherGen=gen;
otherFitt=fitt;

end

