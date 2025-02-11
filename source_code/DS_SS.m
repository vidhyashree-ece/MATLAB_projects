
clc;
close all;
clear all;
b=input('Enter The input Bits : ');
ln=length(b);

Name = input('Program Executed by :','s');

% Converting bit 0 to -1
for i=1:ln
    if b(i)==0
        b(i)=-1;
    end
end   

% Generating the bit sequence with each bit 8 samples long
k=1;
for i=1:ln
   for j=1:8
       bb(k)=b(i);
       j=j+1;
       k=k+1;
   end
    i=i+1;
end
len=length(bb);
subplot(4,1,1);
stairs(bb,'linewidth',2);
axis([0 len -2 3]);
title('ORIGINAL BIT SEQUENCE b(t)');

% Generating the pseudo random bit pattern for spreading
pr_sig=round(rand(1,len));
for i=1:len
    if pr_sig(i)==0
        pr_sig(i)=-1;
    end
end    
subplot(4,1,2);
stairs(pr_sig,'linewidth',2); 
axis([0 len -2 3]);
title('PSEUDORANDOM BIT SEQUENCE pr');

% merge=strcat(Name,'-',datestr(now,30));
% sub_label(merge); % need to include in working directory
% print(merge,'-dpdf')

% Multiplying bit sequence with Pseudorandom Sequence
for i=1:len
   bbs(i)=bb(i).*pr_sig(i);
end

% Modulating the hopped signal
dsss=[];
t=0:1/10:2*pi;   
c1=cos(t);
c2=cos(t+pi);

for k=1:len
    if bbs(1,k)==-1
        dsss=[dsss c1];
    else
        dsss=[dsss c2];
    end
end
% figure,
subplot(4,1,3);
stairs(bbs,'linewidth',2); 
axis([0 len -2 3]);
title('MULTIPLIER OUTPUT SEQUENCE b(t)*pr-sig(t)');
subplot(4,1,4);
plot(dsss);
title(' DS-SS SIGNAL...');

merge=strcat(Name,'-',datestr(now,30));
sub_label(merge); % need to include in working directory
print(merge,'-dpdf')
