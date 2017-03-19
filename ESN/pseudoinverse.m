function outputWeights = pseudoinverse(stateCollectMat, teachCollectMat)
% compute the outputWeights using the standard pseudoinverse operation
%
% inputs arguments:
% stateCollectMat = matrix of size (nTrainingPoints-nForgetPoints) x
% nInputUnits + nInternalUnits 
% stateCollectMat(i,j) = internal activation of unit j after the 
% (i + nForgetPoints)th training point has been presented to the network
% teacherCollectMat is a nSamplePoints * nOuputUnits matrix that keeps
% the expected output of the ESN
% teacherCollectMat is the transformed(scaled, shifted etc) output
%
% output arguments:
% outputWeights = vector of size (nInputUnits + nInternalUnits) x 1
% containing the learnt weights
%
% Version 1.0, May 16, 2013
  
outputWeights = (pinv(stateCollectMat)*teachCollectMat)' ; 