function internalWeights = generate_internal_weights(nInternalUnits, ...
                                                  varS)
% create a random reservoir for an ESN
%  
%%%%%inputs arguments:
% nInternalUnits = the number of internal units in the ESN
% connectivity in [0,1], says how many weights should be non-zero 
%
%%%%%output arguments:
% internalWeights = matrix of size nInternalUnits x nInternalUnits
% internalWeights(i,j) = value of weight from unit i to unit j
% internalWeights(i,j) might be different from internalWeights(j,i)
%
%Version 1.0, May 16, 2013
success = 0 ;                                               
while success == 0
    try,
        internalWeights = sprand(nInternalUnits, nInternalUnits, varS(1,2));
        internalWeights(internalWeights ~= 0) = internalWeights(internalWeights ~= 0)  - varS(1,1);
        maxVal = max(abs(eigs(internalWeights)));
        internalWeights = internalWeights/maxVal;
        success = 1 ;
    catch,
        success = 0 ; 
    end
end
