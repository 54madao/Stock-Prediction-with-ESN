function internalWeights = scr(nInternalUnits)
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
        internalWeights=zeros(nInternalUnits, nInternalUnits);
        for i=1:nInternalUnits-1
            internalWeights(i+1,i)=0.5;
        end
        internalWeights(1,nInternalUnits)=0.5;
        success = 1 ;   
    catch,
        success = 0 ; 
    end
end

