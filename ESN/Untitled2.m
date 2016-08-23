
[num txt raw]=xlsread('A.xls');
l=length(num);
time=datenum(txt(:,2));
re=zeros(l,2);
re=[time num];
t1=datenum('2010-06-01');
i=1;
while(i<l)  
    t2=re(i,1);
    if(t2<t1)
        re(i,:)=[];
        l=l-1;
        i=i-1;
    end
    i=i+1;
end
%n=find(re==0);
%dlmwrite('2.txt',re,'delimiter','\t','newline','pc','precision', 6);
