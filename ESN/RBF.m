%data_r=load('test.txt');
%data_r=data_r(1:1200,1);
clear all
data=load('data601919.txt');
data=data(1:1230,1);
inputMax=max(data');
inputMin=min(data');
P_r=zeros(1200,30);
for k=1:1200
    P_r(k,:)=data(k:k+29,1);
end
T_r=data(31:1230,1);
%输入样本数据
%P_r = data_r;
%T_r = data_r;
train_fraction = 0.8 ; 
[traininputSeq_r, testinputSeq_r] = ...
    split_train_test(P_r,train_fraction);
[trainoutputSeq_r,testoutputSeq_r] = ...
    split_train_test(T_r,train_fraction);

%inputMax = max(traininputSeq_b');
%inputMin = min(traininputSeq_b');
traininputSeq_r = (traininputSeq_r-inputMin)/(inputMax-inputMin);
trainoutputSeq_r =(trainoutputSeq_r-inputMin)/(inputMax-inputMin);
testinputSeq_r = (testinputSeq_r - inputMin)/(inputMax - inputMin);
%n_b=size(traininputSeq_b,1);
%建立网络
net = newrbe( traininputSeq_r' ,trainoutputSeq_r',15) ;
%初始化
net = init (net) ;
%for k_b=1:960
   % y=sim(net,traininputSeq_r(k_b,:)');
    
%end 
%y=sim(net,traininputSeq_r');

predictedTestOutput_r=zeros(1,240);
for j_r=1:240

%网络仿真
predictedTestOutput_r(1,j_r) = sim(net ,testinputSeq_r(j_r,:)') ; %仿真计算
end
predictedTestOutput_r=predictedTestOutput_r*(inputMax-inputMin)+inputMin;
predictedTestOutput_r=predictedTestOutput_r(1,101:end);
testoutputSeq1_r=testoutputSeq_r(101:end,1);
testError_r = sum((predictedTestOutput_r' - testoutputSeq1_r).^2)/length(predictedTestOutput_r)
%perf = perform(net,predictedTestOutput_r,testoutputSeq_r')
figure (1) ;
plot (testoutputSeq1_r,'r') %画图
title('testing: teacher sequence (red) vs predicted sequence (blue)')
hold on ; 
plot (predictedTestOutput_r)



