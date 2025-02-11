clc;
clear;
close all;
Tb=1;
fc=10;
t1=0;t2=Tb;
t=t1:Tb/100:t2;
%===================================================================
% GENERATE MESSAGE SIGNAL
m=input('Enter the input binary sequence');
N=length(m);
%===================================================================
% Plot the input binary data
subplot(5,1,1);
stem(m);
title('binary data bits');
xlabel('n--->');
ylabel('b(n)');
grid on
%====================================================================
% GENERATE CARRIER SIGNAL
c=sqrt(2/Tb)*sin(2*pi*fc*t);
% Plot the carrier signal
subplot(5,1,2);
plot(t,c);
title('carrier signal');
xlabel('t--->');
ylabel('c(t)');
grid on
for i=1:N
%==================================================================
% to generate msg_modified
t=[t1:Tb/100:t2];
if m(i)>0.5
m(i)=1;
m_s=ones(1,length(t));
else
m(i)=0;
m_s=zeros(1,length(t));
end
message(i,:)=m_s;
%====================================================================
% Product of carrier and message_modified
ask_sig(i,:)=c.*m_s;
t1=t1+(Tb+.01);
t2=t2+(Tb+.01);
%=====================================================================
% Plot the message signal
subplot(5,1,3);
axis([0 N -2 2]);
plot(t,message(i,:),'r');
xlim([0 8])
title('message signal');
xlabel('t--->');
ylabel('m(t)');
grid on
hold on
%======================================================================
% Plot the ASK modulated signal
subplot(5,1,4);
plot(t,ask_sig(i,:));
xlim([0 8])
title('ASK modulated signal');
xlabel('t--->');
ylabel('s(t)');grid on
hold on
end
hold off
%========================================================================
% ASK Demodulation
% t1=0;t2=Tb;
for i=1:N
t=[t1:Tb/100:t2];
% correlator
x=sum(c.*ask_sig(i,:));
% decision device
if x>0
demod(i)=1;
else
demod(i)=0;
end
t1=t1+(Tb+.01);
t2=t2+(Tb+.01);
end
%=======================================================================
% Plot the ASK demodulated binary data bits
subplot(5,1,5);
stem(demod);
title('ASK demodulated binary data bits');
xlabel('n--->');
ylabel('b(n)');
grid on
