clc;
clear all;
close all;
%x=[1 2 3 4 5 6 7 8];
%N=[8];
x=input('Enter the input x=');
N=input('Enter the order of DFT N=');
k=0:1:N-1;
disp('Input Sequence x=');
disp(x);
XK=fft(x,N);
disp('XK=');
disp(XK);
R=real(XK);
disp('Real part=');
disp(R);
I=imag(XK);
disp('Imaginary part=');
disp(I);
mag=abs(XK);
disp('Magnitude=');
disp(mag);
ang=angle(XK);
disp('Angle=');
disp(ang);
xn=ifft(XK,N);
disp('IDFT xn=');
disp(xn);

figure(1);
subplot(2,1,1);
stem(x);
xlabel('time-->');
ylabel('Amplitude-->');
title('Given Sequence')

subplot(2,1,2);
stem(R,'r*');
hold on;
stem(I);
legend('Real part','Imaginary part');
xlabel('time-->');
ylabel('Amplitude-->');
title('Discrete fourier transform')

figure(3);
subplot(2,2,1);
stem(k,mag);
xlabel('time-->');
ylabel('x(k)-->');
title('Magnitude Response')

subplot(2,2,2);
stem(k,ang);
xlabel('time-->');
ylabel('ang x(k)-->');
title('Phase Response')

subplot(2,2,3);
stem(k,xn);
xlabel('time-->');
ylabel('x(n)-->');
title('Inverse Discrete Fourier Transform')

%spectrum analysis
Fs=[10];
xdft=XK(1:N/2+1);
psdx=(1/(Fs*N))*abs(xdft).^2;
psdx(2:end-1)=2*psdx(2:end-1);
freq=0:Fs/N:Fs/2;
subplot(2,2,4);
plot(freq,psdx);
grid on;
xlabel('hz-->');
ylabel('db');
title('Spectrum Analysis DFT')
disp('Spectrum Analysis DFT=');
disp(psdx);




