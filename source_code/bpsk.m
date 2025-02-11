clc
clear
close all

num_symbols=10000;
int_symbols=randi([1,2],1,num_symbols);
bpsk_symbols=zeros(size(int_symbols));
bpsk_symbols(int_symbols==1)=1;
bpsk_symbols(int_symbols==2)=-1;

plot(real(bpsk_symbols),imag(bpsk_symbols),'ored','linewidth',3);
xlim([-2 2]);
ylim([-2 2]);
title('BPSK constellation');
xlabel('real part');
ylabel('imaginary part');
grid on;