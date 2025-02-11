clc;
close all;
clear all;

fp=1200;
fsp=2400;
fs=10000;
Rp=1;
Rs=6;
wp=2*fp/fs;
ws=2*fsp/fs;
[N,wc]=buttord(wp,ws,Rp,Rs);
omega_c=2*fs*tan(pi*wc/2);
[b,a]=butter(N,wc,'high');
freqz(b,a,fs);
title('IIR Butterworth HPF');
printsys(b,a,'z');
