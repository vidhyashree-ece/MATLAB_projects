clc
clear 
close all

fs=8000;
fm=10;
fc=200;

t=(0:0.2*fs)/fs;
Am=1;
Ac=1;
kf=2;

m=Am*cos(2*pi*fm*t);
subplot(4,1,1);
plot(t,m);
grid on
title('Message Signal');
xlabel('Time(ms)');
ylabel('Amplitude(V)');

c=Ac*cos(2*pi*fc*t);
subplot(4,1,2);
plot(t,c);
title('Carrier Signal');
xlabel('Time');
ylabel('Amplitude');

n=cumsum(m)/max(cumsum(m));
s_fm=Ac*cos((2*pi*fc*t)+2*pi*kf*n);
subplot(4,1,3);
plot(t,s_fm);
title(' Frequency Modulated Signal');
xlabel('Time');
ylabel('Amplitude');

demod=fmdemod(s_fm,fc,fs,max(cumsum(m)));
subplot(4,1,4);
plot(t,demod);
title('Demodulated Signal');
xlabel('Time');
ylabel('Amplitude');
ylim([-1 1])

