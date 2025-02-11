clc;
close all;
clear all;
 
fp=1200;
fsp=2400;
fs=10000;
Rp=1;
Rs=6;
wp=(2*fp)/fs;
ws=(2*fsp)/fs;
[N,wc]=buttord(wp,ws,Rp,Rs);
wc=[wp ws];
[b,a]=butter(N,wc,'stop');
freqz(b,a,fs);
title('IIR BUTTERWORTH BSF');
printsys(b,a,'z');
