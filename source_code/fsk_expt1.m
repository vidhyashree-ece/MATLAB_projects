clc;
clear all;
t=0:0.0001:0.25;

m=square(2*pi*t*10);
c1=sin(2*pi*t*60);
c2=sin(2*pi*t*120);

for i=1:2500
    if m(i)==1
       Output(i)=c1(i);
    else 
       Output(i)=c2(i);
    end 
end

subplot(4,1,1);
plot(m);
title('Message Signal');
xlabel('t(ms)');
ylabel('amp(v)');

subplot(4,1,2);
plot(c1);
title('Carrier 1');
xlabel('t(ms)');
ylabel('amp(v)');

subplot(4,1,3);
plot(c2);
title('Carrier 2');
xlabel('t(ms)');
ylabel('amp(v)');

subplot(4,1,4);
plot(Output);
title('fsk Modulated Signal');
xlabel('t(ms)');
ylabel('amp(v)');
xlim ([0 3000]);

