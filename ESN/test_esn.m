function outputSequence = test_esn(inputSequence, esn, nForgetPoints, varargin)
% run a trained ESN on a particular inputSequence
% input arguments:  
% inputSequence: is a nTestingPoints * nInputUnits matrix that contains 
% the input we will run the esn on
% esn: the trained ESN structure 
% nForgetPoints: nr of initial time points to be discarded
%
% ouput arguments:
% outputSequence is an array of size (size(inputSequence, 1)-nForgetPoints)
% x esn.nOutputUnits
%
% Version 1.0, May 16, 2013

stateCollection = compute_statematrix(inputSequence, [], esn, nForgetPoints) ;     
outputSequence = stateCollection * esn.outputWeights' ; 

%%%% scale and shift the outputSequence back to its original size
nOutputPoints = length(outputSequence(:,1)) ; 
outputSequence = feval(esn.outputActivationFunction, outputSequence); 
outputSequence = outputSequence - repmat(esn.teacherShift',[nOutputPoints 1]) ; 
outputSequence = outputSequence / diag(esn.teacherScaling) ; 
