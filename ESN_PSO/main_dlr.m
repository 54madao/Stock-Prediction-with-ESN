function [bestResult,telapsed,bestError,bestPredictedOutput] = main_dlr(parNumber,nInputUnits,nInternalUnits,nOutputUnits,rType,goal,traininputSeq,testinputSeq,trainoutputSeq,testoutputSeq,dataMax,dataMin)
%MAIN_DLR Summary of this function goes here
%   Detailed explanation goes here

%SR,v,r
parlength=3;
%---------------------------init swarm-------------------------------------
[parSwarm,optSwarm,disSwarm]=InitSwarm(parNumber,parlength);


%--------------------------------------------------------------------------
% set the number of Input,Internal,Output units
inputScaling=ones(nInputUnits,1);
inputShift=zeros(nInputUnits,1);
bestError=1;
partFraction=0.8;
%goalError=1;
maxLoop=50;
loopNum=maxLoop;
maxVel=0.1;
l=length(testoutputSeq);
predictedOutput=ones(l-100,maxLoop);
frac=0;
count=0;
tic;
tstart=tic;
const=1/partFraction;
while(loopNum~=0 && bestError>goal)
%     disp(maxLoop);
%     disp(bestError);
    
    count=count+const;
    for i=1:parNumber
        %---------------------------generate an esn--------------------------------
        %disp('Generate an ESN ............');
        varSwarm=parSwarm(i,1:parlength);
        % generate the ESN
        %disp(rType);
        esn = generate_esn(nInputUnits, nInternalUnits, nOutputUnits,rType,varSwarm, ...
            'inputScaling',inputScaling,'inputShift',inputShift, ...
            'teacherScaling',[1],'teacherShift',[0],'feedbackScaling', 0, ...
            'type', 'plain_esn');
        % rescale the internalWeights with spectralRadius
        esn.internalWeights = varSwarm(1,1) * esn.internalWeights_NonRS;
        %disp('Generating accomplished ............');
        %--------------------------------------------------------------------------
        
        
        
        %----------------------------train the ESN---------------------------------
        %disp('Train the ESN ............');
        % the first nForgetPoints of Sequences will be disregarded (washing out initial
        % reservoir transient)
        nForgetPoints = 100 ;
        [trainedEsn stateMatrix] = ...
            train_esn(traininputSeq, trainoutputSeq, esn, nForgetPoints) ;
        %disp('Training accomplished ............');
        %--------------------------------------------------------------------------
        
        %------------------------------test the ESN--------------------------------
        %disp('Test the ESN ............');
        % compute the output of the trained ESN on the training and testing set,
        % discarding the first nForgetPoints of each
        nForgetPoints =100 ;
        % test the trained ESN on the test set
        predictedTestOutput = test_esn(testinputSeq,  trainedEsn, nForgetPoints) ;
        predictedTestOutput=predictedTestOutput*(dataMax - dataMin)+dataMin;
        %disp('Testing accomplished ............');
        %--------------------------------------------------------------------------
        
        %----------------------compute testing error-------------------------------
        
        testError = compute_error(predictedTestOutput, testoutputSeq);
        % MSEList(i, 1) = testError;
        % if testError < recordMSE
        %     recordMSE = testError;
        %     %save bestModel  trainedEsn;
        %     bestPredictedTestOutput=predictedTestOutput;
        %     bestStateMatrix=stateMatrix;
        % end
        if testError<parSwarm(i,end)
            optSwarm(i,:)=varSwarm;
            parSwarm(i,end)=testError;
            predictedOutput(:,i)=predictedTestOutput;
        end
        %--------------------------------------------------------------------------
    end
    frac=count/maxLoop;
%     disp('frac:')
%     disp(frac);
    if frac>1
        adaptValue=parSwarm(:,end);
        [bestError row]=min(adaptValue);
        %optSwarm(1:end-1,:)=parSwarm(:,1:parlength);
        optSwarm(end,:)=parSwarm(row,1:parlength);
        bestPredictedOutput=predictedOutput(:,row);
%         For each particle
%         ________Calculate particle velocity according equation (a)
%         ________Update particle position according equation (b)
%         ____End
        subP=optSwarm(1:end-1,:)-parSwarm(:,1:parlength);
        subB=repmat(optSwarm(end,:),parNumber,1);
        subO=subB-parSwarm(:,1:parlength);
        %
        tempVel=parSwarm(:,parlength+1:2*parlength)+2*rand()*subP+2*rand()*subO;
        tempVel(tempVel>maxVel)=maxVel;
        tempVel(tempVel<-maxVel)=-maxVel;
        %
        parSwarm(:,parlength+1:2*parlength)=tempVel;
        %
        tempPos=parSwarm(:,1:parlength)+tempVel;
        %
        tempPos(tempPos>1)=1;
        tempPos(tempPos<=0)=0.000000001;
        %
        parSwarm(:,1:parlength)=tempPos;
    else
%         disp('parSwarm:')
%         disp(parSwarm);
        disSwarm=pdist2(parSwarm(:,1:parlength),parSwarm(:,1:parlength));
%         disp('disSwarm:')
%         disp(disSwarm);
        Dm=max(max(disSwarm));
%         disp('Dm:')
%         disp(Dm);
        
         disSwarm=disSwarm/Dm;
%         %copySwarm=disSwarm;
%         disSwarm(disSwarm>=frac)=0;
%         %copySwarm(copySwarm>=frac)=0;
%         %copySwarm=copySwarm+diag(ones(1,parNumber));
%         disSwarm=disSwarm+diag(ones(1,parNumber));
%         %disSwarm=disSwarm.*copySwarm;
%         disSwarm(disSwarm~=0)=1;
%         adaptValue=parSwarm(:,end);
%         disSwarm=disSwarm.*repmat(adaptValue',parNumber,1);
%         disSwarm(disSwarm==0)=1000000000;
%         [I J]=min(disSwarm,[],2);
%         
%         subB=parSwarm(J,1:parlength);
%         subP=optSwarm(1:end-1,:)-parSwarm(:,1:parlength);
%         %subB=repmat(optSwarm(end,:),parNumber,1);
%         subO=subB-parSwarm(:,1:parlength);
%         %
%         tempVel=parSwarm(:,parlength+1:2*parlength)+2*rand()*subP+2*rand()*subO;
%         tempVel(tempVel>maxVel)=maxVel;
%         tempVel(tempVel<-maxVel)=-maxVel;
%         %
%         parSwarm(:,parlength+1:2*parlength)=tempVel;
%         %
%         tempPos=parSwarm(:,1:parlength)+tempVel;
%         %
%         tempPos(tempPos>1)=1;
%         tempPos(tempPos<=0)=0.000000001;
%         %
%         parSwarm(:,1:parlength)=tempPos;
        
        
        
        for m=1:parNumber
            recordError=1000000000;
            for n=1:parNumber
                if disSwarm(m,n)<frac
                    if parSwarm(n,end)<recordError
                        row=n;
                        recordError=parSwarm(n,end);
                    end
                end
            end
%             disp('row:')
%             disp(row);
            subP=optSwarm(m,:)-parSwarm(m,1:parlength);
            subB=parSwarm(row,1:parlength);
            subO=subB-parSwarm(m,1:parlength);
            %
            tempVel=parSwarm(m,parlength+1:2*parlength)+2*rand()*subP+2*rand()*subO;
            tempVel(tempVel>maxVel)=maxVel;
            tempVel(tempVel<-maxVel)=-maxVel;
            %
            parSwarm(m,parlength+1:2*parlength)=tempVel;
            %
            tempPos=parSwarm(m,1:parlength)+tempVel;
            %
            tempPos(tempPos>1)=1;
            tempPos(tempPos<=0)=0.000000001;
            %
            parSwarm(m,1:parlength)=tempPos;
        end
     end
    
    
    
    
    
    
    
    
%     adaptValue=parSwarm(:,end);
%     [bestError row]=min(adaptValue);
%     %optSwarm(1:end-1,:)=parSwarm(:,1:parlength);
%     optSwarm(end,:)=parSwarm(row,1:parlength);
%     bestPredictedOutput=predictedOutput(:,row);
%     For each particle
% ________Calculate particle velocity according equation (a)
% ________Update particle position according equation (b)
% ____End
%     subP=optSwarm(1:end-1,:)-parSwarm(:,1:parlength);
%     subB=repmat(optSwarm(end,:),parNumber,1);
%     subO=subB-parSwarm(:,1:parlength);
%     %
%     tempVel=parSwarm(:,parlength+1:2*parlength)+2*rand()*subP+2*rand()*subO;
%     tempVel(tempVel>maxVel)=maxVel;
%     tempVel(tempVel<-maxVel)=-maxVel;
%     %
%     parSwarm(:,parlength+1:2*parlength)=tempVel;
%     %
%     tempPos=parSwarm(:,1:parlength)+tempVel;
%     %
%     tempPos(tempPos>1)=1;
%     tempPos(tempPos<=0)=0.000000001;
%     %
%     parSwarm(:,1:parlength)=tempPos;
    %
    %goalError=abs(bestError-recordError)/bestError;
    %disp(goalError);
    %     if bestError<recordError
    %         recordError=bestError;
    %     end
%     if bestError==recordError
%         count=count+1;
%         if count==2;
%             maxLoop=maxLoop+1;
%             count=0;
%         end
%     else
%         recordError=bestError;
%         count=0;
%     end
    loopNum=loopNum-1;
end
bestResult=optSwarm(end,:);
telapsed=toc(tstart)/maxLoop;
end

