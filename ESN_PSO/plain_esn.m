function internalState = plain_esn(totalstate , esn , varargin)
% compute the new internal states of the ESN 
%
% input arguments:
% totalstate: the previous totalstate, vector of size 
%     (esn.nInternalUnits + esn.nInputUnits + esn.nOutputUnits) x 1
% esn: the ESN structure
%
% output arguments: 
% internalState: the updated internal state, size esn.nInternalUnits x 1
%
% Version 1.0, May 16, 2013


% compute a new internal state
internalState =  feval( esn.reservoirActivationFunction , ...
    [esn.internalWeights , esn.inputWeights , esn.feedbackWeights * diag(esn.feedbackScaling )] * totalstate)  ;   
% add noise to the ESN 
internalState = internalState + esn.noiseLevel * (rand(esn.nInternalUnits,1) - 0.5) ; 

