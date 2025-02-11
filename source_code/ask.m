clc
clear
close all;
f1=25;
f2=5;
a=3;
t=0:0.001:1;
x=a/2.*square(2*pi*f2*t)+(a/2);
y=a.*sin(2*pi*f1*t)+(a/2);
v=y.*x;
subplot(3,1,1);
plot(t,x);
title('message signal');
grid on;
subplot(3,1,2);
plot(t,y);
title('carrier signal');
grid on;
subplot(3,1,3);
plot(t,v);
title('ASK modulated signal');
grid on;