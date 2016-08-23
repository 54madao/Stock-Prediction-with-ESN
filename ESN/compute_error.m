function meanerror = compute_error(estimatedOutput, correctOutput)
% Compute the MSE between estimated and correct ESN outputs.
% 
% input arguments:
% estimatedOutput: array of size N1 x outputDimension, containing network
% output data.
% correctOutput: array of size N2 x outputDimension, containing the
% original teacher data. 
%
% output arguments:
% meanerror: a row vector of MSE's, each corresponding to one of the output
% dimensions.
%
% Version 1.0, May 16, 2013
  
  
nEstimatePoints = length(estimatedOutput) ; 
nForgetPoints = length(correctOutput) - nEstimatePoints ; 
correctOutput = correctOutput(nForgetPoints+1:end,:) ; 

i=1;
if i==1
    meanerror = sum((estimatedOutput - correctOutput).^2)/nEstimatePoints ;
else
    meanerror = sum(abs((estimatedOutput - correctOutput)./correctOutput))*100/nEstimatePoints;

end



