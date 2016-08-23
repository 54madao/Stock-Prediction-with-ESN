function stateCollectMat = ...
    compute_statematrix(inputSequence, outputSequence, esn, nForgetPoints, varargin)

% compute_statematrix runs the input through the ESN and writes the
% obtained input+reservoir states into stateCollectMat.
% The first nForgetPoints will be deleted, as the first few states could be
% not reliable due to initial transients  
%
% inputs arguments:
% inputSequence = input time series of size nTrainingPoints x nInputDimension
% outputSequence = output time series of size nTrainingPoints x nOutputDimension
% esn = an ESN structure, through which we run our input sequence
% nForgetPoints: an integer, may be positive or zero.
%    If positive: the first nForgetPoints will be disregarded (washing out
%    initial reservoir transient)
%    If zero: no washout accounted for, all states except the zero starting
%    state will be sorted into state matrix
%
% output arguments:
% stateCollectMat = matrix of size (nTrainingPoints-nForgetPoints) x
% nInputUnits + nInternalUnits 
% stateCollectMat(i,j) = internal activation of unit j after the 
% (i + nForgetPoints)th training point has been presented to the network
%
% Version 1.0, May 16, 2013

if isempty(inputSequence) && isempty(outputSequence)
    error('error in compute_statematrix: two empty input args');
end
if isempty(outputSequence)
    teacherForcing = 0;
    nDataPoints = length(inputSequence(:,1));
else
    teacherForcing = 1;
    nDataPoints = length(outputSequence(:,1));
end
stateCollectMat = ...
zeros(nDataPoints - nForgetPoints, esn.nInputUnits + esn.nInternalUnits) ; 
totalstate = zeros(esn.nInputUnits + esn.nInternalUnits + esn.nOutputUnits, 1);
internalState = zeros(esn.nInternalUnits, 1);

collectIndex = 0;
for i = 1:nDataPoints
    % scale and shift the value of the inputSequence
    in = esn.inputScaling .* inputSequence(i,:)' + esn.inputShift;  % in is column vector  
    % write input into totalstate
    totalstate(esn.nInternalUnits+1:esn.nInternalUnits + esn.nInputUnits) = in;
    %compute the internal State based on the type of the ESN
    internalState = feval(esn.type, totalstate, esn) ; 
    if teacherForcing
        netOut = esn.teacherScaling .* outputSequence(i,:)' + esn.teacherShift;
    else        
        netOut = feval(esn.outputActivationFunction, esn.outputWeights * [internalState; in]);
    end
    totalstate = [internalState; in; netOut];
    %collect state
    if i > nForgetPoints
        collectIndex = collectIndex + 1;
        stateCollectMat(collectIndex,:) = [internalState' in']; 
    end
    
end
