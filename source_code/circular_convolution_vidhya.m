clear all;
close all;
x=input('Enter the first sequence');
N1=length(x);
h=input('Enter the second sequence');
N2=length(h);
n=0:1:N1-1;
subplot(2,2,1);
stem(n,x);
xlabel('Time');
ylabel('Amplitude');
title('X sequence response');
n=0:1:N2-1;
subplot(2,2,2);
stem(n,h);
xlabel('Time');
ylabel('Amplitude');
title('H sequence Response');

for n=1:N1
    y(n)=0;
    for i=1:N2;
        j=n-i+1;
        if(j<=0)
            j=N2+j;
    end
    y(n)=[y(n)+x(i)*h(j)];
    end
end
disp('convolution of X&H is');
subplot(2,2,3);
stem(y);
xlabel('Time');
ylabel('Amplitude');
title('Convolution of X&H Response');

    