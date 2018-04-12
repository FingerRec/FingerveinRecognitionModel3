hidden = 50
iteration = 300
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
%person:100
numClasses = personNumber;
trainFeatures = zeros(numFeature,trainNumber);
for i = 1:personNumber
    trainFeatures(:,((i-1)*trainEveryPerson+1):((i)*trainEveryPerson)) = TrainFeatures(:,((i-1)*fingerNumEveryPerson+predFinger-trainEveryPerson):((i-1)*fingerNumEveryPerson+predFinger-1));
end
testFeatures = zeros(numFeature,testNumber);
for i = 1:personNumber
    testFeatures(:,i) = TrainFeatures(:,((i-1)*fingerNumEveryPerson+predFinger));
end
save testData testFeatures testLabels
save trainData trainFeatures trainLabels