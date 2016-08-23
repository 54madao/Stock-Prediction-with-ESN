function [trained_esn, stateCollection] = ...
    train_esn(trainInput, trainOutput , esn, nForgetPoints)
% Train the output weights of an ESN 
% it computes the weights using the method esn.methodTrain(using pseudo-inverse)
% 
%%%%%%inputs arguments:
% trainInput = input vector of size nTrainingPoints x nInputDimension
% trainOutput = teacher vector of size nTrainingPoints x nOutputDimension
% esn = an ESN structure, through which we run our input sequence
% nForgetPoints = the first nForgetPoints will be disregarded
%
%%%%%%outputs arguments:
% trained_esn = an Esn structure with the option trained = 1 and 
% outputWeights set. 
% stateCollection = matrix of size (nTrainingPoints-nForgetPoints) x
% nInputUnits + nInternalUnits 
% stateCollectMat(i,j) = internal activation of unit j after the 
% (i + nForgetPoints)th training point has been presented to the network
% teacherCollection is a nSamplePoints * nOuputUnits matrix that keeps
% the expected output of the ESN
% teacherCollection is the transformed(scaled, shifted etc) output
%
% Version 1.0, May 16, 2013


trained_esn = esn;
% trainInput and trainOutput each represent a single time series in
% an array of size sequenceLength x sequenceDimension

% compute the state matrix
stateCollection = compute_statematrix(trainInput, trainOutput, trained_esn, nForgetPoints) ; 

% compute the tearcher matrix
teacherCollection = compute_teacher(trainOutput, trained_esn, nForgetPoints) ;

% compute the output weights
trained_esn.outputWeights = feval(trained_esn.methodWeightCompute, stateCollection, teacherCollection) ;    
if trained_esn.outputWeights==0
    trained_esn.trained = 0 ;
% represent this ESN has been trained
else
    trained_esn.trained = 1 ;
end


