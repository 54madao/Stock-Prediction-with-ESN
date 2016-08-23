function [ bestResult,telapsed,bestError,bestPredictedOutput ] = main_bp( parNumber,nInputUnits,nInternalUnits,nOutputUnits,rType,goal,traininputSeq,testinputSeq,trainoutputSeq,testoutputSeq,dataMax,dataMin )
%MAIN_BP Summary of this function goes here
%   Detailed explanation goes here

%s
parlength=1;
%---------------------------init swarm-------------------------------------
[parSwarm,optSwarm,disSwarm]=InitSwarm(parNumber,parlength);
parSwarm(:,1:parlength)=parSwarm(:,1:parlength)*29+1;

parSwarm(:,parlength+1:2*parlength)=parSwarm(:,parlength+1:2*parlength)*10;

%--------------------------------------------------------------------------
nForgetPoints = 100 ;
bestError=1;
partFraction=0.8;
maxLoop=10;
loopNum=maxLoop;
maxVel=1;
l=length(testoutputSeq);
predictedOutput=ones(l-nForgetPoints,maxLoop);
frac=0;
count=0;
tic;
tstart=tic;
const=1/partFraction;
while(loopNum~=0 && bestError>goal)
    %     disp(maxLoop);
    %     disp(bestError);
%     disp('loopNum:');
%     disp(loopNum);
    count=count+const;
    for i=1:parNumber
%         disp('parNum:');
%         disp(i);
        %---------------------------generate an rbf--------------------------------
        %disp('Generate an ESN ............');
        
        varSwarm=round(parSwarm(i,1:parlength));   
        %disp(varSwarm);
        %建立网络
        net = newff ( traininputSeq' ,trainoutputSeq',varSwarm,{ 'logsig','purelin'} ,'trainlm', 'learngdm','mse') ;
        %初始化
        net = init (net) ;
        %for k_b=1:960
        %网络训练
        net.trainParam.showWindow=0;
        net. trainParam. show = 100 ; %设置训练显示间隔次数
        net. trainParam. epochs = 20000 ; %设置最大训练循环次数
        net. trainParam. goal = 0.0001 ; %设置性能目标值
        net. trainParam. lr = 0.01 ; %设置学习系数
        %[ net ,tr ] = train(net ,traininputSeq_b(k_b,:)',trainoutputSeq_b(k_b,1)') ; %网络训练
        [ net ,tr ] = train(net ,traininputSeq',trainoutputSeq') ;
        %网络仿真
        %end
%         predictedTestOutput=zeros(1,l);
%         for j_b=1:l
%             predictedTestOutput(j_b,1) = sim(net ,testinputSeq(j_b,:)') ; %仿真计算
%         end
        predictedTestOutput=net(testinputSeq');
        predictedTestOutput=predictedTestOutput*(dataMax-dataMin)+dataMin;
        predictedTestOutput=predictedTestOutput(1,nForgetPoints+1:end);
        predictedTestOutput=predictedTestOutput';
        testError = compute_error(predictedTestOutput, testoutputSeq);      
        %disp(testError);
        if testError<parSwarm(i,end)
            optSwarm(i,:)=varSwarm;
            parSwarm(i,end)=testError;
            predictedOutput(:,i)=predictedTestOutput;
        end
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
        tempPos(tempPos>30)=30;
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
            tempPos(tempPos>30)=30;
            tempPos(tempPos<=1)=1.000000001;
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
bestResult=round(optSwarm(end,:));
telapsed=toc(tstart)/maxLoop;
end

