clc;
clear;
close all; 

Tb=4;
fc1=2;
fc2=5;
t=0:(Tb/100):Tb;

% Generate message signal
m=input('Enter the input binary sequence');
N=length(m);
t1=0;
t2=Tb;

% Plotting binary data bits
subplot(6,1,1);
stem(m);
title('binary data bits');
xlabel('n---->');
ylabel('b(n)');
grid on;
xlim([1 8]);
ylim([0 1]);

% GENERATE CARRIER SIGNALS
c1=sqrt(2/Tb)*sin(2*pi*fc1*t);
c2=sqrt(2/Tb)*sin(2*pi*fc2*t);

% Plotting carrier signal 1
subplot(6,1,2);
plot(t,c1);
title('carrier signal-1');
xlabel('t---->');
ylabel('c1(t)');
grid on;

% Plotting carrier signal 2
subplot(6,1,3);
plot(t,c2);
title('carrier signal-2');
xlabel('t---->');
ylabel('c2(t)');
grid on;
for i=1:N
t=[t1:(Tb/100):t2];
if m(i)>0.5
   m(i)=1;
   m_s=ones(1,length(t));
   invm_s=zeros(1,length(t));
else
   m(i)=0;
   m_s=zeros(1,length(t));
   invm_s=ones(1,length(t));
end
message(i,:)=m_s;

% Multiplier
fsk_sig1(i,:)=c1.*m_s;
fsk_sig2(i,:)=c2.*invm_s;
fsk=fsk_sig1+fsk_sig2;

% Plotting the message signal
subplot(6,1,4);
axis([0 N -2 2]);
plot(t,message(i,:),'r');
xlim([0 8]);
title('message signal');
xlabel('t---->');
ylabel('m(t)');
grid on;
hold on;

% Plotting the BFSK modulated signal
subplot(6,1,5);
plot(t,fsk(i,:));
xlim([0 8]);
title('BFSK modulated signal');
xlabel('t---->');
ylabel('s(t)');
grid on;
hold on;
t1=t1+(Tb+.01);
t2=t2+(Tb+.01);
end
hold off

% BFSK Demodulation
t1=0;t2=Tb;
for i=1:N
    t=[t1:(Tb/100):t2];

%correlator
x1=sum(c1.*fsk_sig1(i,:));
x2=sum(c2.*fsk_sig2(i,:));
x=x1-x2;

%decision device
if x>0
   demod(i)=1;
else
   demod(i)=0;
end
t1=t1+(Tb+.01);
t2=t2+(Tb+.01);
end

% Plotting the BFSK demodulated binary data bits
subplot(6,1,6);
stem(demod);
title('BFSK demodulated binary data bits');
xlabel('n---->');
ylabel('b(n)');
grid on;