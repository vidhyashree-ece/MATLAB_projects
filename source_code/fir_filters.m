clc;
clear all;
close all;
N=input('Enter the Value of N:');
wc=input('Enter the cutoff frequency');

%FIR Lowpass filter using Hamming Window
h=fir1(N,wc/pi,hamming(N+1));
figure(1);
freqz(h);
title('DIGITAL HAMMING LOWPASS FILTER');

%FIR Highpass filter using Hamming Window
h=fir1(N,wc/pi,'high',hamming(N+1));
figure(2);
freqz(h);
title('DIGITAL HAMMING HIGHPASS FILTER');

%FIR Bandpass filter using Hamming Window
wcc=[wc-.2*pi,wc+.2*pi];
h=fir1(N,wcc/pi,hamming(N+1));
figure(3);
freqz(h);
title('DIGITAL HAMMING BANDPASS FILTER');

%FIR Stoppass filter using Hamming Window
wcs=[wc-.3*pi,wc+.3*pi];
h=fir1(N,wcs/pi,'stop',hamming(N+1));
figure(4);
freqz(h);
title('DIGITAL HAMMING BAND STOP FILTER');


