function [input,output,time,dataMax,dataMin] = load_data( dataName,datalength,delay)
%Load the data

%%%%% input arguments:
% dataName: the name of the experiment data 
% datalength: the length of experiment data
% delay: the delay between input and output
%

%%%%% optional arguments:
% input: input data for ESN
% output: output data for ESN
% time: time list
%
% Version 1.0, May 16, 2013
data=load(dataName);

length(data);
%time=load('time.txt');
time=data(delay+1:datalength,1);
%disp(time);
%time=time(delay+1:datalength,1);
%time=time+datenum('1899-12-30');
data=data(1:datalength,2);
dataMax=max(data');
dataMin=min(data');
data = (data - dataMin)/(dataMax - dataMin);
input=zeros(datalength-delay,delay);
for k=1:datalength-delay
    input(k,:)=data(k:k+delay-1,1);
end
output=data(delay+1:datalength,1);
end

