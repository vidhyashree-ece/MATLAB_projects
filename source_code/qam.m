clc;
clear all;
M=64;
x=randint(100e3,1,M);
y=modulate(modem.qammod(M),x);
ynoisy=awgn(y,27,'measured');
scatterplot(ynoisy),grid;
z=demodulate(modem.qamdemod(M),ynoisy);
figure (2);
subplot(2,1,1);
stem(x(1:10),'filled'),grid;
title('transmitted data') 
subplot(2,1,2);
stem(z(1:10),'filled'),grid;
title('received data');
[num ty]=symerr(x,z)
