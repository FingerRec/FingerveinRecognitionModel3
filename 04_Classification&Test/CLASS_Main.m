clc;
clear;
close all;
softlamda = 1e-9;
maxlamda = 1e-4;
for hidden = 50:50:100
    for i = 3:2:7
       softlamda = 1e-9;
       while(softlamda<maxlamda)
           [pred,softmaxY] = classificationForSoftmax( hidden,i*100,softlamda);
           plot(pred,softmaxY,'rx');
           title('Sofmax Classification');
           xlabel('Pred');
           ylabel('Real');
           softlamda = softlamda * 8;
       end
    end 
end