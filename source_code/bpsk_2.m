clc;
clear;
close all;
Tb=1;
t=0:Tb/100:Tb;
fc=2;
% Generate message signal
m = input('Enter the input binary sequence');
N=length(m);
t1=0;t2=Tb;
% Plot the input binary data
subplot(5,1,1);
stem(m);
title('binary data bits');
xlabel('n--->');
ylabel('b(n)');
grid on
% GENERATE CARRIER SIGNAL
c=sqrt(2/Tb)*sin(2*pi*fc*t);
% Plot the carrier signal
subplot(5,1,3);
plot(t,c);
title('carrier signal');
xlabel('t--->');
ylabel('c(t)');
grid on
for i=1:N
% to generate msg_modified
t=[t1:.01:t2];
if m(i)>0.5
m(i)=1;
m_s=ones(1,length(t));
else
m(i)=0;
m_s=-1*ones(1,length(t));
end
message(i,:)=m_s;
% Plot the message signal
subplot(5,1,2);
axis([0 N -2 2]);
plot(t,message(i,:),'r');
xlim([0 8])
title('message signal(POLAR form)');
xlabel('t--->');
ylabel('m(t)');
grid on;hold on;
% Product of carrier and message_modified
bpsk_sig(i,:)=c.*m_s;
% Plot the BPSK modulated signal
subplot(5,1,4);
plot(t,bpsk_sig(i,:));
xlim([0 8])
title('BPSK modulated signal');
xlabel('t--->');
ylabel('s(t)');
grid on; hold on;
t1=t1+1.01;
t2=t2+1.01;
end
hold off
% BPSK Demodulation
t1=0;t2=Tb;
for i=1:N
t=[t1:.01:t2];
% correlator
x=sum(c.*bpsk_sig(i,:));
% decision device
if x>0
demod(i)=1;
else
demod(i)=0;
end
t1=t1+1.01;
t2=t2+1.01;
end
% Plot the BPSK demodulated binary data bits
subplot(5,1,5);
stem(demod);
title('BPSK demodulated binary data bits');
xlabel('n--->');
ylabel('b(n)');
grid on;