function [train,test] = split_train_test(sample, trainPercentage)
% split the "sample" time series into a train and a 
% test subsequence such that the train subsequence has a length of 
% trainPercentage of the original sample length
%
%Version 1.0, May 16, 2013

nSamplePoints = size(sample, 1) ; 
nTrainPoints = floor(nSamplePoints * trainPercentage) ; 
  
train = sample(1:nTrainPoints,:) ; 
test  = sample(nTrainPoints+1:end,:) ; 


  
