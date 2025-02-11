clc
clear
close all

num_symbols=10000;
int_symbols=randi([1,4],1,num_symbols);% 10000 random numbers in the range 1-4
A=1/sqrt(2);
qpsk_symbols=zeros(size(int_symbols));
qpsk_symbols(int_symbols==1)=A+1i*A;
qpsk_symbols(int_symbols==2)=A-1i*A;
qpsk_symbols(int_symbols==3)=-A+1i*A;
qpsk_symbols(int_symbols==4)=-A-1i*A;

plot(real(qpsk_symbols),imag(qpsk_symbols),'ored','linewidth',3);
xlim([-2 2]);
ylim([-2 2]);
title('QPSK constellation');
xlabel('real part');
ylabel('imaginary part');
grid on;