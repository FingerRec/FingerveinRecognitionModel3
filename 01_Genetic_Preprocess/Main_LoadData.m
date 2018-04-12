clear; 
clc; 
close all;
imageNumber=3600;
maxGeneration=100;
maxPopulation=100;
elitismProb=0.01;
mutationProb=0.1;
mutationNum=0.05;

load('trainHistArray.mat');
load('trainRawData.mat');
finalChr={[]};

for i=3:4
    img=Origin(:,:,i)*255;
    hstg=GetHist(img);
    idx=find(HistArray(1,:)==size(hstg,1));
    if HistArray(2,idx)==0
        continue;
    else
        HistArray(2,idx)=HistArray(2,idx)-1;
    end
    Gen=InitializeGen(maxPopulation,size(hstg,1));
    for generation=1:maxGeneration
        fprintf('Calc Generation %d Out of %d For Image %d Out of %d\n',...
            generation,maxGeneration,i,imageNumber);
        fittness=GetFittness(img,hstg,Gen);
        [top, otherGen, otherFitt]=Elitism(Gen,fittness,elitismProb);
        newGen=CrossOver(otherGen,otherFitt);
        newGen=Mutation(newGen,mutationProb, mutationNum);
        Gen(:,1:size(top,2))=top;
        Gen(:,size(top,2)+1:end)=newGen;
    end
    fittness=GetFittness(img,hstg,Gen);
    top=Gen(:,fittness==max(fittness));
    finalChr(end+1)={top};
end

finalChr=finalChr(2:end);
save('testFinalChromo some.mat','finalChr');
