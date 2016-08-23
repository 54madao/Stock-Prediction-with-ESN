for n=1:26
    sheet=64;
    sheet=sheet+n;
    sheet=char(sheet);
[num txt raw]=xlsread('B.xls',sheet);
s1=txt(1,1);
s1=char(s1);
l1=length(num);
time=datenum(txt(:,2));
re=zeros(l1,2);
re=[time num];
t1=datenum('2010-06-01');
first=1;
last=0;
for i=1:l1
    s2=txt(i,1);
    s2=char(s2);
    if(~strcmp(s1,s2))
        last=i;
        s3=strcat(s1,'.txt');
        co=re(first:last-1,:);
        %l2=last-first;
        %j=1;
        %while(j<l2)
            %disp(j);
            %t2=co(j,1);
            %if(t2<=t1)
                %co(j,:)=[];
                %l2=l2-1;
                %j=j-1;
            %end
            %j=j+1;
         %end
         [l2 l3]=size(co);
         if(l2>=930)
             co=co(end+1-930:end,:);
         end
        dlmwrite(s3,co,'delimiter','\t','newline','pc','precision', 6);
        %fid = fopen(s3,'w+');
        %fclose(fid);        
        s1=s2;
        first=last;
    else  
        if(i==l1)
            s3=strcat(s1,'.txt');
            %fid = fopen(s3,'w+');
            %fclose(fid);
            co=re(first:i,:);
            %l2=i+1-first;
            %j=1;
            %while(j<l2)
                %disp(j);
                %t2=co(j,1);
                %if(t2<=t1)
                    %co(j,:)=[];
                    %l2=l2-1;
                    %j=j-1;
                %end
                %j=j+1;
            %end
            [l2 l3]=size(co);
            if(l2>=930)
                co=co(end+1-930:end,:);
            end
            dlmwrite(s3,co,'delimiter','\t','newline','pc','precision', 6);    
        end
    end
         
end
end
%dlmwrite('A.txt', kb, 'delimiter', '\t');
%dlmwrite('A.txt',txt,'delimiter','','newline','pc');
%disp(txt{2,2});