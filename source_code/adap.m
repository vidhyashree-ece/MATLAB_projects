clc;
clear;
close all;

% Parameters
numSymbols = 1000;        % Number of transmitted symbols
filterOrder = 5;          % Order of the equalizer filter
stepSize = 0.01;          % LMS algorithm step size
snr = 20;                 % Signal-to-noise ratio in dB

Name = input('Program Executed by :','s');

% Generate random transmitted symbols
txSymbols = 2 * (rand(numSymbols, 1) > 0.5) - 1; % Binary PAM symbols (+1/-1)

% Simulate a channel with ISI
channel = [0.9 0.5 0.3];  % Example channel impulse response
rxSignal = filter(channel, 1, txSymbols);

% Add noise to the received signal
rxSignalNoisy = awgn(rxSignal, snr, 'measured');

% Plot the results
figure;

% Plot received signal (before equalization)
subplot(2, 1, 1);
plot(rxSignalNoisy, 'b');
title('Received Signal (Before Equalization)');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;

% Initialize the adaptive equalizer
equalizerWeights = zeros(filterOrder, 1); % Filter weights
equalizerWeights(ceil(filterOrder/2)) = 1; % Initial tap is 1 for direct path
equalizedSignal = zeros(numSymbols, 1);

% Adaptive equalization using LMS
for n = filterOrder:numSymbols
    % Extract a window of received samples
    x = rxSignalNoisy(n:-1:n-filterOrder+1);
    
    % Compute the equalizer output
    y = equalizerWeights' * x;
    equalizedSignal(n) = y;
    
    % Compute the error
    error = txSymbols(n) - y;
    
    % Update the weights using LMS
    equalizerWeights = equalizerWeights + stepSize * error * x;
end

% Plot equalized signal (after equalization)
subplot(2, 1, 2);
plot(equalizedSignal, 'r');
title('Equalized Signal (After Equalization)');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;

merge=strcat(Name,'-adap-eqaliz-',datestr(now,30));
sub_label(merge); % need to include in working directory
print(merge,'-dpdf')