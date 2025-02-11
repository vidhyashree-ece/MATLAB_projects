clc;
clear all;
close all;
N=input('Enter the value of N:');
wc=input('Enter cutoff frequency:');
%FIR LOWPASS FILTER USING HANNING WINDOW
h=fir1(N,wc/pi,hanning(N+1));
figure(1);
freqz(h);
title('Digital Hanning Low pass Filter');
%FIR HIGHPASS FILTER USING HANNING WINDOW
h=fir1(N,wc/pi,'HIGH',hanning(N+1));
figure(2);
freqz(h);
title('Digital Hanning High pass Filter');
%FIR BANDPASS FILTER USING HANNING WINDOW
wcc=[wc-.2*pi,wc+.2*pi];
h=fir1(N,wcc/pi,hanning(N+1));
figure(3);
freqz(h);
title('Digital Hanning Band pass Filter');
%FIR BANDSTOP FILTER USING HANNING WINDOW
wcc=[wc-.2*pi,wc+.2*pi];
h=fir1(N,wcc/pi,'STOP',hanning(N+1));
figure(4);
freqz(h);
title('Digital Hanning Band Stop Filter');

