clc;
clear;
close all;

% Parameters
N = 1000;                % Number of symbols
SNR = 20;                % Signal-to-Noise Ratio in dB
channel = [1 0.5 0.3];   % Channel coefficients
feedback_taps = 2;       % Number of feedback taps
feedforward_taps = 3;    % Number of feedforward taps


Name = input('Program Executed by :','s');

% Generate random BPSK symbols
data = randi([0, 1], N, 1) * 2 - 1;

% Plotting
figure;

% Original Signal
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

% Received Signal (with ISI and Noise)
subplot(3,1,2);
stem(noisy_signal(1:50), 'filled');
title('Received Signal (with ISI and Noise)');
xlabel('Symbol Index');
ylabel('Amplitude');
grid on;

% LMS Adaptive DFE Initialization
ff_weights = zeros(feedforward_taps, 1);       % Feedforward filter weights
fb_weights = zeros(feedback_taps, 1);          % Feedback filter weights
mu = 0.01;                                     % Step size for LMS

% Equalization and Decoding
equalized_signal = zeros(N, 1);
detected_signal = zeros(N, 1);

for n = max(feedforward_taps, feedback_taps)+1:N
    % Feedforward filter
    ff_input = noisy_signal(n:-1:n-feedforward_taps+1);
    ff_output = ff_weights' * ff_input;

    % Feedback filter
    fb_input = detected_signal(n-1:-1:n-feedback_taps);
    fb_output = fb_weights' * fb_input;
    
    % Total equalizer output
    equalized_signal(n) = ff_output - fb_output;
    
    % Decision
    detected_signal(n) = sign(equalized_signal(n));
    
    % LMS Update for Feedforward and Feedback Weights
    error = data(n) - equalized_signal(n);
    ff_weights = ff_weights + mu * error * ff_input;
    fb_weights = fb_weights + mu * error * fb_input;
end

% Equalized Signal using DFE
subplot(3,1,3);
stem(detected_signal(1:50), 'filled');
title('Equalized Signal using DFE');
xlabel('Symbol Index');
ylabel('Amplitude');
grid on;

merge=strcat(Name,'-DFE-',datestr(now,30));
sub_label(merge); % need to include in working directory
print(merge,'-dpdf')