function [ fittness ] = GetFittness( img, hstg, gen )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%   fittness function
%   fitness(x)=log(log(E(I(X))))*n_edges(I(x))
fittness=zeros(size(gen,2),1);
for g=1:size(fittness,1)
    tmp=RemapHist(img,hstg,gen(:,g));
    BW = edge(tmp,'sobel');
    edges=sum(sum(BW));
    intensity=0;
    for i=2:39
        for j=2:79
            intensity=intensity+sqrt(H_Value(i,j,tmp)+V_Value(i,j,tmp));
        end
    end
    fittness(g)=log(log(intensity))*edges;
end

end

