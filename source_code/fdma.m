% To model and simulate FDMA for wireless communication

clc;
clear;
close all;

Name = input('Program Executed by :','s');

% System parameters
totalBandwidth = 10e6; % Total available bandwidth (Hz)
numUsers = 5; % Number of users
carrierFrequency = 1e6; % Carrier frequency (Hz)
userBandwidth = totalBandwidth / numUsers; % Bandwidth allocated to each user (Hz)

% Time parameters
samplingFrequency = 100e6; % Sampling frequency (Hz)
timeDuration = 1e-3; % Simulation duration (s)
time = 0:1/samplingFrequency:timeDuration;

% Generate user signals
userSignals = zeros(numUsers, length(time));

for i = 1:numUsers
    userFrequency = carrierFrequency + (i-1) * userBandwidth; % Frequency of user signal
    userSignals(i, :) = sin(2*pi*userFrequency*time);
end

% Create the FDMA signal
fdmaSignal = sum(userSignals, 1);

% Add noise to the FDMA signal
snr = 10; % Signal-to-Noise Ratio (in dB)
noisySignal = awgn(fdmaSignal, snr, 'measured');

% Perform signal demodulation
demodulatedSignals = zeros(numUsers, length(time));

for i = 1:numUsers
    userFrequency = carrierFrequency + (i-1) * userBandwidth; % Frequency of user signal
    demodulatedSignals(i, :) = noisySignal .* sin(2*pi*userFrequency*time);
end

% Plot the original user signals and the demodulated signals
figure;
subplot(numUsers+1, 1, 1);
plot(time, fdmaSignal);
title('FDMA Signal');
xlabel('Time (s)');
ylabel('Amplitude');

for i = 1:numUsers
    subplot(numUsers+1, 1, i+1);
    plot(time, demodulatedSignals(i, :));
    title(['Demodulated Signal - User ', num2str(i)]);
    xlabel('Time (s)');
    ylabel('Amplitude');
end

merge=strcat(Name,'-FDMA-',datestr(now,30));
sub_label(merge); % need to include in working directory
print(merge,'-dpdf')