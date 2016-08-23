function teachCollectMat = compute_teacher(outputSequence, esn, ...
    nForgetPoints)
% scale, shift and apply the inverse output
% activation function on the exepcted teacher data. 
% the first nForgetPoints are being disregarded
%
% inputs arguments:
% outputSequence = teacher vector of size nTrainingPoints x nOutputDimension
% esn = an ESN structure, which contains the information about the
% transformation we need to apply to the teacher 
% nForgetPoints: an integer, may be positive or zero.
%    If positive: the first nForgetPoints will be disregarded (washing out
%    initial reservoir transient)
%    If zero: no washout accounted for, all states except the zero starting
%    state will be sorted into state matrix
%
% outputs arguments:
% teachCollectMat = matrix of size (nOutputPoints - nForgetPoints) x
% nOutputUnits
% teachCollectMat contains the shifted and scaled output
%
% Version 1.0, May 16, 2013

nOutputPoints  = length(outputSequence(:,1)) ; 
teachCollectMat = zeros(nOutputPoints - max([0, nForgetPoints]), esn.nOutputUnits) ;

% delete the first nForgetPoints elements from outputSequence
outputSequence = outputSequence(nForgetPoints+1:end,:) ; 

% update the size of outputSequence
nOutputPoints  = length(outputSequence(:,1)) ; 

%rescale and shift the teacher data
teachCollectMat = [(diag(esn.teacherScaling) * outputSequence')' + ...
        repmat(esn.teacherShift',[nOutputPoints 1])];

teachCollectMat = feval(esn.inverseOutputActivationFunction, teachCollectMat);




