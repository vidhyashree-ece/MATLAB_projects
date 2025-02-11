clc
clear all
close all

Am=1;
fm=10;
fs=1000;
Ac=2;
fc=100;
t=0:0.001:0.5;

m=Am*sin(2*pi*fm*t);
subplot(4,1,1);
plot(t,m);
grid on
title('Message Signal');
xlabel('Time(ms)');
ylabel('Amplitude(v)');

c=Ac*sin(2*pi*fc*t);
subplot(4,1,2);
plot(t,c);
title('Carrier Signal');
xlabel('Time(ms)');
ylabel('Amplitude(v)');

k=Am/Ac;
s1=(1+k*m).*c;
subplot(4,1,3);
plot(t,s1,t,Ac+m,t,-Ac-m);
title('Amplitude Modulated Signal');
xlabel('Time(ms)');
ylabel('Amplitude(v)');

s2=(1/pi)*(Ac+m);
subplot(4,1,4);
plot(t,m,t,s2);
title('Demodulated Signal');
xlabel('Time(ms)');
ylabel('Amplitude(v)');
