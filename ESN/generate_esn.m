function esn = generate_esn(nInputUnits, nInternalUnits, nOutputUnits,reservoirType,varargin)
%%%%% input arguments:
% nInputUnits: the dimension of the input 
% nInternalUnits: size of the Esn
% nOutputUnits: the dimension of the output
%
%%%%% optional arguments:
% 'inputScaling': a nInputUnits x 1 vector
% 'inputShift': a nInputUnits x 1 vector. 
% 'teacherScaling': a nOutputUnits x 1 vector
% 'teacherShift': a nOutputUnits x 1 vector. 
% 'noiseLevel': a small number containing the amount of uniform noise to be
%  added when computing the internal states
% 'reservoirActivationFunction': a string ("tanh", "identity") ,
% 'outputActivationFunction': a string("tanh", "identity") ,
% 'inverseOutputActivationFunction': the inverse to
%    outputActivationFunction, one of 'atanh', 'identity', 'sigmoid01_inv'.
%    When choosing the activation function, make sure the inverse
%    activation function is corectly set.
% 'methodWeightCompute': a string ('pseudoinverse', 'wiener_hopf'). It  
%    specifies which method to use to compute the output weights given the
%    state collection matrix and the teacher
% 'spectralRadius': a positive number less than 1. 
% 'feedbackScaling': a nOutputUnits x 1 vector, indicating the scaling
%     factor to be applied on the output before it is fed back into the network
% 'type': a string ('plain_esn')
% 'trained': a flag indicating whether the network has been trained already
%
% Version 1.0, May 16, 2013

% set the number of units
esn.nInternalUnits = nInternalUnits; 
esn.nInputUnits = nInputUnits; 
esn.nOutputUnits = nOutputUnits; 

% set the density of the internal units
connectivity = min([7/nInternalUnits 1]);
%connectivity = 0.2;
%generate the internal weights of ESN that hasn's been rescaled
if strcmp(reservoirType,'stdesn')
    esn.internalWeights_NonRS = generate_internal_weights(nInternalUnits, ...
                                                connectivity);
else
    %disp(reservoirType);
    esn.internalWeights_NonRS = feval(reservoirType, nInternalUnits) ;
end
esn.nTotalUnits = nInternalUnits + nInputUnits + nOutputUnits;

% input weight matrix has weight vectors per input unit in colums
% which is selected randomly from [-1,1]
inc=1;
if inc==0
    esn.inputWeights = 2.0 * rand(nInternalUnits, nInputUnits)- 1.0;
else   
    A=randi([0 1],nInternalUnits,nInputUnits);
    A(A==0)=-1;
    esn.inputWeights =ones(nInternalUnits,nInputUnits)-0.5;
    esn.inputWeights=esn.inputWeights.*A; 
end

% output weight matrix has weights for output units in rows
% includes weights for input-to-output connections
esn.outputWeights = zeros(nOutputUnits, nInternalUnits + nInputUnits);

%output feedback weight matrix has weights in columns
% which is selected randomly from [-1,1]
esn.feedbackWeights = (2.0 * rand(nInternalUnits, nOutputUnits)- 1.0);

%init default parameters
esn.inputScaling  = ones(nInputUnits, 1);  
esn.inputShift    = zeros(nInputUnits, 1);
esn.teacherScaling = ones(nOutputUnits, 1);
esn.teacherShift  = zeros(nOutputUnits, 1);
esn.noiseLevel = 0.0001 ; 
esn.reservoirActivationFunction = 'tanh';
esn.outputActivationFunction = 'identity' ; 
esn.methodWeightCompute = 'pseudoinverse' ; 
esn.inverseOutputActivationFunction = 'identity' ; 
esn.spectralRadius = 1 ; 
esn.feedbackScaling = zeros(nOutputUnits, 1); 
esn.trained = 0 ; 
esn.type = 'plain_esn' ; 

%set parameters by the user
args = varargin; 
nargs= length(args);
for i=1:2:nargs
    %disp(args{i});
  switch args{i},
   case 'inputScaling', esn.inputScaling = args{i+1} ; 
   case 'inputShift', esn.inputShift= args{i+1} ; 
   case 'teacherScaling', esn.teacherScaling = args{i+1} ; 
   case 'teacherShift', esn.teacherShift = args{i+1} ;     
   case 'noiseLevel', esn.noiseLevel = args{i+1} ; 
   case 'reservoirActivationFunction',esn.reservoirActivationFunction=args{i+1};
   case 'outputActivationFunction',esn.outputActivationFunction=  ...
                        args{i+1};        
   case 'inverseOutputActivationFunction', esn.inverseOutputActivationFunction=args{i+1}; 
   case 'methodWeightCompute', esn.methodWeightCompute = args{i+1} ; 
   case 'spectralRadius', esn.spectralRadius = args{i+1} ;  
   case 'feedbackScaling',  esn.feedbackScaling = args{i+1} ; 
   case 'type' , esn.type = args{i+1} ;   
   otherwise error('the option does not exist'); 
  end      
end

%%%% error checking
% check that inputScaling has correct format
if size(esn.inputScaling,1) ~= esn.nInputUnits
    error('the size of the inputScaling does not match the number of input units'); 
end
if size(esn.inputShift,1) ~= esn.nInputUnits
    error('the size of the inputScaling does not match the number of input units'); 
end
if size(esn.teacherScaling,1) ~= esn.nOutputUnits
    error('the size of the teacherScaling does not match the number of output units'); 
end
if size(esn.teacherShift,1) ~= esn.nOutputUnits
    error('the size of the teacherShift does not match the number of output units'); 
end
if ~((strcmp(esn.outputActivationFunction,'identity') && ...
        strcmp(esn.inverseOutputActivationFunction,'identity')) || ...
        (strcmp(esn.outputActivationFunction,'tanh') && ...
        strcmp(esn.inverseOutputActivationFunction,'atanh')) || ...
        (strcmp(esn.outputActivationFunction,'sigmoid01') && ...
        strcmp(esn.inverseOutputActivationFunction,'sigmoid01_inv')))  ...
error('outputActivationFunction and inverseOutputActivationFunction do not match'); 
end


