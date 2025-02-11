clc;
close all;
clear all;

fp=1200;
fsp=2400;
fs=10000;
rp=1;
rs=6;
wp=2*(fp/fs);
ws=2*(fsp/fs);
[N,wc]=cheb1ord(wp,ws,rp,rs);
wc=[wp ws];
[b,a]=cheby1(N,rp,wc);
freqz(b,a,fs);
title('chebyshev LPF');
printsys(b,a,'z');
