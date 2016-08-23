function [bestStateMatrix,bestPredictedTestOutput,testoutputSeq,MSEList,testTime] = main(name,testNumber,nInputUnits,nInternalUnits,nOutputUnits,spectralRadius,train_fraction,rType)
% training and testing an ESN on a stock time series prediction task.
%%%%% input arguments:
% name: the name of input data
% testNumber: the number of test
% nInputUnits: the dimension of the input 
% nInternalUnits: size of the Esn
% nOutputUnits: the dimension of the output
% spectralRadius: a positive number less than 1. 
% train_fraction:split the input time series into a train and a 
% test subsequence with this percentage
%
%%%%%% optional arguments:
% bestStateMatrix: the matrix of internal states of the best prediction
% size (nTrainingPoints-nForgetPoints) x nInputUnits + nInternalUnits 
% bestPredictedTestOutput: the best prediction the ESN can ever provide
% during the test
% size (size(inputSequence, 1)-nForgetPoints) x esn.nOutputUnits
% testoutputSeq: containing the original teacher data. 
% MSEList: the list of errors
% testTime: the time of test time series 
%
% Version 1.0, May 16, 2013

%disp('Begin ............');
%------------------------load the stock data----------------------------
%disp('Load data ............');
[inputSeq,outputSeq,time,dataMax,dataMin]=load_data(name,930,nInputUnits);
%disp('Loading data accomplished ............');
%--------------------------------------------------------------------------

%--------------split the data into train set and test set------------------
% use train_fraction in training and 1-train_fraction in testing
[trainTime, testTime] = ...
    split_train_test(time,train_fraction);
[traininputSeq, testinputSeq] = ...
    split_train_test(inputSeq,train_fraction);
[trainoutputSeq,testoutputSeq] = ...
    split_train_test(outputSeq,train_fraction);
testoutputSeq=testoutputSeq*(dataMax - dataMin)+dataMin;
%--------------------------------------------------------------------------

MSEList = zeros(testNumber,1);
recordMSE = 10;
tic;
for i=1:testNumber
%---------------------------generate an esn--------------------------------
%disp('Generate an ESN ............');
% set the number of Input,Internal,Output units
inputScaling=ones(nInputUnits,1);
inputShift=zeros(nInputUnits,1);
% generate the ESN
%disp(rType);
esn = generate_esn(nInputUnits, nInternalUnits, nOutputUnits,rType, ...
    'spectralRadius',spectralRadius,'inputScaling',inputScaling,'inputShift',inputShift, ...
    'teacherScaling',[1],'teacherShift',[0],'feedbackScaling', 0, ...
    'type', 'plain_esn'); 
% rescale the internalWeights with spectralRadius
esn.internalWeights = esn.spectralRadius * esn.internalWeights_NonRS;
%disp('Generating accomplished ............');
%--------------------------------------------------------------------------

%----------------------------train the ESN---------------------------------
%disp('Train the ESN ............');
% the first nForgetPoints of Sequences will be disregarded (washing out initial 
% reservoir transient)
nForgetPoints = 100 ; 
[trainedEsn stateMatrix] = ...
    train_esn(traininputSeq, trainoutputSeq, esn, nForgetPoints) ; 
%disp('Training accomplished ............');
%--------------------------------------------------------------------------

%------------------------------test the ESN--------------------------------
%disp('Test the ESN ............');
% compute the output of the trained ESN on the training and testing set,
% discarding the first nForgetPoints of each
nForgetPoints =100 ; 
% test the trained ESN on the test set
predictedTestOutput = test_esn(testinputSeq,  trainedEsn, nForgetPoints) ; 
predictedTestOutput=predictedTestOutput*(dataMax - dataMin)+dataMin;
%disp('Testing accomplished ............');
%--------------------------------------------------------------------------

%----------------------compute testing error-------------------------------

testError = compute_error(predictedTestOutput, testoutputSeq); 
MSEList(i, 1) = testError;
if testError < recordMSE
    recordMSE = testError;
    %save bestModel  trainedEsn;
    bestPredictedTestOutput=predictedTestOutput;
    bestStateMatrix=stateMatrix;
end
%--------------------------------------------------------------------------
end
toc
end

