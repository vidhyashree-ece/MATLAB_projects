clc;
clear all;
close all;
N=input('Enter the Value of N:');
wc=input('Enter the Cutoff Frequency:');
%FIR LOWPASS FILTER USING RECTANGUALR WINDOW
h=fir1(N,wc/pi,rectwin(N+1));
figure(1);
freqz(h);
title('Digital Rectangular Low pass Filter');
%FIR HIGH PASS FILTER USING RECTANGULAR WINDOW
h=fir1(N,wc/pi,'high',rectwin(N+1));
figure(2);
freqz(h);
title('Digital Rectangular High pass Filter');
%FIR BAND PASS FILTER USING RECTANGULAR WINDOW
wcc=[wc-.2*pi,wc+.2*pi];
h=fir1(N,wcc/pi,rectwin(N+1));
figure(3);
freqz(h);
title('Digital Rectangular Band pass Filter');
%FIR STOP PASS FILTER USING RECTANGULAR WINDOW
wcs=[wc-.3*pi,wc+.3*pi];
h=fir1(N,wcs/pi,'stop',rectwin(N+1));
figure(4);
freqz(h);
title('Digital Rectangular Band Stop Filter');
