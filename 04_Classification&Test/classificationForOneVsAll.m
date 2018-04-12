clc;
clear;
close all;

%%Setup the parameters
load('TrainFeatures_H125_I700.mat');
trainEveryPerson = 5;
testEveryPerson = 1;

personNumber = 100;
numFeature = 1000;
trainNumber = personNumber * trainEveryPerson;
testNumber = personNumber * testEveryPerson;
trainLables = zeros(trainNumber,1);
testLabels = zeros(testNumber,1);
for i = 1 : personNumber
    trainLabels((i-1)*trainEveryPerson+1:i*trainEveryPerson,1) = i;
    testLabels(i,1) = i;
end
%% ============ Part 1: Vectorize Logistic Regression ============
%  
fprintf('\nTraining One-vs-All Logistic Regression...\n')

trainFeatures = zeros(numFeature,trainNumber);
for i = 1:100
    trainFeatures(:,((i-1)*trainEveryPerson+1):i*trainEveryPerson) = TrainFeatures(:,((i-1)*36+20):((i-1)*36+24));
end

X = imresize(trainFeatures,[500,1000]);
y = trainLabels;
num_labels = 500;
lambda = 0.05;%0.1
[all_theta] = oneVsAll(X, y, num_labels, lambda);

%% ================ Part 2: Predict for One-Vs-All ================
%  After ...
for i = 1:100
    testFeatures(:,i) = TrainFeatures(:,((i-1)*36+19));
end
X = imresize(testFeatures,[100,1000]);
y = testLabels;
pred = predictOneVsAll(all_theta, X);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);