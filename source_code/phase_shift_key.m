clc
clear 
close all

t=0:0.0001:0.25;
m=square(2*pi*t*10);
c=sin(2*pi*t*60);

for i=1:2500
    if m(i)==1
        output(i)=c(i);
    else 
        output(i)=-c(i);
    end
end


subplot(4,1,1);
plot(t,m);
grid on
title('Message Signal');
xlabel('Time(ms)');
ylabel('Amplitude(V)');

subplot(4,1,2);
plot(t,c);
title('Carrier Signal');
xlabel('Time');
ylabel('Amplitude');

subplot(4,1,3);
plot(output);
title('psk Modulated Signal');
xlabel('t(ms)');
ylabel('amp(v)');
xlim ([0 3000]);
