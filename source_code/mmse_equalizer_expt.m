clc;
clear;
close all;

% Parameters
N = 1000;                % Number of symbols
SNR = 20;                % Signal-to-Noise Ratio in dB
channel = [1 0.5 0.3];   % Channel coefficients

Name = input('Program Executed by :','s');

% Generate random BPSK symbols
data = randi([0, 1], N, 1) * 2 - 1;

% Plotting
figure;

% Original signal
subplot(3,1,1);
stem(data(1:50), 'filled');
title('Original Transmitted Signal');
xlabel('Symbol Index');
ylabel('Amplitude');
grid on;

% Transmit through the channel
received_signal = conv(data, channel, 'same');

% Add noise
noisy_signal = awgn(received_signal, SNR, 'measured');

% Received signal (with ISI and noise)
subplot(3,1,2);
stem(noisy_signal(1:50), 'filled');
title('Received Signal (with ISI and Noise)');
xlabel('Symbol Index');
ylabel('Amplitude');
grid on;

% MMSE Equalizer
H = toeplitz([channel, zeros(1, N - length(channel))]);  % Channel matrix
noise_variance = 10^(-SNR/10);                          % Noise variance
H_mmse = (H' * H + noise_variance * eye(N)) \ H';       % MMSE filter
equalized_signal = H_mmse * noisy_signal;

% Equalized signal
subplot(3,1,3);
stem(equalized_signal(1:50), 'filled');
title('Equalized Signal using MMSE');
xlabel('Symbol Index');
ylabel('Amplitude');
grid on;

merge=strcat(Name,'-MMSE-',datestr(now,30));
sub_label(merge); % need to include in working directory
print(merge,'-dpdf')