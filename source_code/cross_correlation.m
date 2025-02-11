clc;
clear all;
close all;
x=input('Enter the 1st sequence');
h=input('Enter the 2nd sequence');
y=xcorr(x,h);
figure;
subplot(3,1,1);
stem(x);
ylabel('Amplitude-->.');
xlabel('(a)n-->.');
title('input sequence');
subplot(3,1,2);
stem(h);
ylabel('Amplitude-->.');
xlabel('(b)n-->.');
title('Impulse response');
subplot(3,1,3);
stem(fliplr(y));
ylabel('Amplitude-->.');
xlabel('(c)n-->.');
title('Cross correlated sequence');
disp('The Resultant Signal is');
fliplr(y)


