path = 'histArray.mat';
load(path);
trainEveryPerson = 5;
testEveryPerson = 1;
fingerNumEveryPerson = 36;%36 fingers in database
predFinger = 30;%the 18th finger in the database for every-person
personNumber = 50;
imageSize = 40*80;
trainNumber = personNumber * trainEveryPerson;
testNumber = personNumber * testEveryPerson;

%person:100
numClasses = personNumber;
trainFeatures = zeros(imageSize,trainNumber);
for i = 1:personNumber
    trainFeatures(:,((i-1)*trainEveryPerson+1):((i)*trainEveryPerson)) =... 
    HistArray(:,((i-1)*fingerNumEveryPerson+predFinger-trainEveryPerson):((i-1)*fingerNumEveryPerson+predFinger-1));
end
testFeatures = zeros(imageSize,testNumber);
for i = 1:personNumber
    testFeatures(:,i) =...
        HistArray(:,((i-1)*fingerNumEveryPerson+predFinger));
end
save imageTestData testFeatures 
save imageTrainData trainFeatures 