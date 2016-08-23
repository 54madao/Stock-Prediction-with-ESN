function [bestPredictedTestOutput,testoutputSeq,testTime,bResult,telapsed,bError] = main(name,parNumber,nInputUnits,nInternalUnits,nOutputUnits,train_fraction,rType,goal)
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
switch rType
    case 'stdesn'
        disp('stdesn');
        mainType='main_stdesn';
    case 'dlr'
        disp('dlr');
        mainType='main_dlr';
    case 'dlrb'
        disp('dlrb');
        mainType='main_dlrb';
    case 'scr'
        disp('scr');
        mainType='main_scr';
    case 'bp'
        disp('bp');
        mainType='main_bp';
     case 'rbf'
        disp('rbf');
        mainType='main_rbf';   
end
% if strcmp(mainType,'main_stdesn')
%     [bResult,telapsed,bError,bestPredictedTestOutput]=feval(mainType, parNumber,nInputUnits,nInternalUnits,nOutputUnits,rType,goal,traininputSeq,testinputSeq,trainoutputSeq,testoutputSeq,dataMax,dataMin) ;
% else
    [bResult,telapsed,bError,bestPredictedTestOutput]=feval(mainType, parNumber,nInputUnits,nInternalUnits,nOutputUnits,rType,goal,traininputSeq,testinputSeq,trainoutputSeq,testoutputSeq,dataMax,dataMin) ;
% end
%MSEList = zeros(parNumber,1);
%recordMSE = 100000000000;


