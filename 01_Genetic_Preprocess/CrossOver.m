function [ newGen ] = CrossOver( gen, fitt )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
%   GAÖÐµÄ·±Ö³²Ù×÷
s=size(gen,1);
newGen=zeros(s,size(gen,2));
for iter=1:size(newGen,2)/2
    idx1=RouletteWheelSelection(fitt);
    idx2=RouletteWheelSelection(fitt);
    parent1=gen(:,idx1);
    parent2=gen(:,idx2);
    pnt=sort(ceil(rand(2,1)*s));
    tmp=parent1(pnt(1):pnt(2),1);
    parent1(pnt(1):pnt(2),1)=parent2(pnt(1):pnt(2),1);
    parent2(pnt(1):pnt(2),1)=tmp;
    newGen(:,2*iter-1)=sort(parent1);
    newGen(:,2*iter)=sort(parent2);
end

end

