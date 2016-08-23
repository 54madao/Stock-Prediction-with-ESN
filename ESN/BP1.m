%data_b=load('test.txt');
%data_b=data_b(1:1200,1);
clear all
data=load('data600016.txt');
data=data(1:1230,1);

inputMax=max(data');
inputMin=min(data');
%data = (data - inputMin)/(inputMax - inputMin);
P_b=zeros(1200,30);
for k=1:1200
    P_b(k,:)=data(k:k+29,1);
end
T_b=data(31:1230,1);
%输入样本数据
%P_b = data_b;
%T_b = data_b;
train_fraction = 0.8 ; 
[traininputSeq_b, testinputSeq_b] = ...
    split_train_test(P_b,train_fraction);
[trainoutputSeq_b,testoutputSeq_b] = ...
    split_train_test(T_b,train_fraction);

%inputMax = max(max(traininputSeq_b'));
%inputMin = max(min(traininputSeq_b'));
%outputMax = max(trainoutputSeq_b');
%outputMin = min(trainoutputSeq_b');
traininputSeq_b = (traininputSeq_b - inputMin)/(inputMax - inputMin);
trainoutputSeq_b =(trainoutputSeq_b - inputMin)/(inputMax - inputMin);
testinputSeq_b = (testinputSeq_b - inputMin)/(inputMax - inputMin);
NMSEList_b = zeros(50,1);
%NMSEList1_b = zeros(50,1);
recordNMSE_b = 1000;
%n_b=size(traininputSeq_b,1);
for i_b=1:50

%建立网络
net = newff ( traininputSeq_b' ,trainoutputSeq_b',10,{ 'logsig','purelin'} ,'trainlm', 'learngdm','mse') ;
%初始化
net = init (net) ;
%for k_b=1:960
%网络训练
net. trainParam. show = 100 ; %设置训练显示间隔次数
net. trainParam. epochs = 20000 ; %设置最大训练循环次数
net. trainParam. goal = 0.0001 ; %设置性能目标值
net. trainParam. lr = 0.01 ; %设置学习系数
%[ net ,tr ] = train(net ,traininputSeq_b(k_b,:)',trainoutputSeq_b(k_b,1)') ; %网络训练
[ net ,tr ] = train(net ,traininputSeq_b',trainoutputSeq_b') ;
%网络仿真
%end
predictedTestOutput_b=zeros(1,240);
for j_b=1:240
predictedTestOutput_b(1,j_b) = sim(net ,testinputSeq_b(j_b,:)') ; %仿真计算
end
predictedTestOutput_b=predictedTestOutput_b*(inputMax-inputMin)+inputMin;
predictedTestOutput_b=predictedTestOutput_b(1,101:end);
testoutputSeq1_b=testoutputSeq_b(101:end,1);
%testoutputSeq2_b=testoutputSeq_b(100:end-1,1);
testError_b = sum((predictedTestOutput_b' - testoutputSeq1_b).^2)/length(predictedTestOutput_b);
%perf = perform(net,predictedTestOutput_b,testoutputSeq1_b')
%testError1_b = sum((predictedTestOutput_b' - testoutputSeq2_b).^2)/length(predictedTestOutput_b);
NMSEList_b(i_b, 1) = testError_b;
if testError_b < recordNMSE_b
    recordNMSE_b = testError_b;
    %save bestModel  trainedEsn;  
    bestPredictedTestOutput_b=predictedTestOutput_b;
end
%NMSEList1_b(i_b, 1) = testError1_b;

%disp(sprintf('test NRMSE = %s', num2str(testError)))
end
%max(NMSEList_b')
disp(sprintf('The best NMSE = %s', num2str(min(NMSEList_b'))))
disp(sprintf('The worst NMSE = %s', num2str(max(NMSEList_b'))))
disp(sprintf('The average NMSE = %s', num2str(mean(NMSEList_b))))
%disp(sprintf('The best NMSE1 = %s', num2str(min(NMSEList1_b'))))
%disp(sprintf('The worst NMSE1 = %s', num2str(max(NMSEList1_b'))))
%disp(sprintf('The average NMSE1 = %s', num2str(mean(NMSEList1_b))))
figure (1) ;
plot (testoutputSeq1_b,'r') %画图
title('testing: teacher sequence (red) vs predicted sequence (blue)')
hold on ; 
plot (bestPredictedTestOutput_b)



