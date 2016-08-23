nInternalUnits=96;
nInputUnits=30;




A=randi([0 1],nInternalUnits,nInputUnits)
nonZerosSum=sum(sum(A~=0,1),2);

disp(nonZerosSum/2880);
    inputWeights =ones(nInternalUnits,nInputUnits)-0.5
    A(A==0)=-1;
    inputWeights=inputWeights.*A
    
    b={'STD ESN','DLR','DLRB','SCR','ALL'}
    b(2)
    