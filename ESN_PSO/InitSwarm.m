function [par,opt,dis] = InitSwarm(parNumber,parlength)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%parNumber=100;

par=rand(parNumber,2*parlength+1);
par(:,parlength+1:2*parlength)=rand(parNumber,parlength)/10;
par(:,end)=ones(parNumber,1)*10000000000;
opt=zeros(parNumber+1,parlength);
dis=zeros(parNumber,parNumber);

