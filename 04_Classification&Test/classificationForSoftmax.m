function [ pred,softmaxY ] = classificationForSoftmax( hidden,iteration,softlamda )
%% SETP1: Use pooled features for classification
% Setup parameters for softmax
path = strcat('TrainFeatures_H',num2str(hidden),'_I',num2str(iteration),'.mat');
load(path);
trainEveryPerson = 5;
testEveryPerson = 1;
fingerNumEveryPerson = 36;%36 fingers in database
predFinger = 30;%the 18th finger in the database for every-person
personNumber = 50;
numFeature = hidden*8;%400-800-100....
trainNumber = personNumber * trainEveryPerson;
testNumber = personNumber * testEveryPerson;
trainLabels = zeros(trainNumber,1);
testLabels = zeros(testNumber,1);
for i = 1 : personNumber
    trainLabels((i-1)*trainEveryPerson+1:i*trainEveryPerson,1) = i;
    testLabels(i,1) = i;
end
%0.98778
%1e-7/3  99.917%
%1e-7/4  99.944%
%1e-7/5 4000 99.972%
%weight a
softmaxLambda = softlamda;
%softmaxLambda = 0.0000003; 
%person:100
numClasses = personNumber;
% softmaxX is the input vector for softmax
% trainLabels is the label for train
trainFeatures = zeros(numFeature,trainNumber);
for i = 1:personNumber
    trainFeatures(:,((i-1)*trainEveryPerson+1):((i)*trainEveryPerson)) = TrainFeatures(:,((i-1)*fingerNumEveryPerson+predFinger-trainEveryPerson):((i-1)*fingerNumEveryPerson+predFinger-1));
end
softmaxX = trainFeatures;
softmaxY = trainLabels;

options = struct;
options.maxIter = 500;
softmaxModel = softmaxTrain(numFeature,...
    numClasses, softmaxLambda, softmaxX, softmaxY, options);

%%======================================================================
%% STEP 2: Test classifer And Plot
%  softmax classifer and plot
testFeatures = zeros(numFeature,testNumber);
for i = 1:personNumber
    testFeatures(:,i) = TrainFeatures(:,((i-1)*fingerNumEveryPerson+predFinger));
end
softmaxX = testFeatures;
softmaxY = testLabels;

[pred] = softmaxPredict(softmaxModel, softmaxX);
acc = (pred(:) == softmaxY(:));
acc = sum(acc) / size(acc, 1);
fid = fopen('FinalResultRecord.txt','at+');
fprintf(fid,'BeginPos:%d,Hidd:%d,FeatIter:%d,MaxIter:%d,Lamda:%.8f;Accuracy: %2.3f%%\n', predFinger,hidden,iteration,options.maxIter,softmaxLambda,acc * 100);
fclose(fid);
%plot(pred,softmaxY,'rx');
%title('Sofmax Classification');
%xlabel('Pred');
%ylabel('Real');
% You should expect to get an accuracy of around 80% on the test images.

end

