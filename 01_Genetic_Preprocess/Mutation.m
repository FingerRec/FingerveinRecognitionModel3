function [ newGen ] = Mutation( gen, prb, num )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   Í»±ä
s=size(gen,1);
newGen=gen;
for i=1:size(newGen,2)
    p=rand(1,1);
    if p>prb
        continue;
    else
        idx=ceil(rand(ceil(255*num),1)*s);
        for id=1:size(idx,1)
            if idx(id)==s
                newGen(idx(id),i)=randi([gen(idx(id)-1,i) 255]);
            else if idx(id)==1
                    newGen(idx(id),i)=randi([0 gen(idx(id)+1,i)]);
                else
                    newGen(idx(id),i)=randi([gen(idx(id)-1,i) gen(idx(id)+1,i)]);
                end
            end
        end
    end
end

end

