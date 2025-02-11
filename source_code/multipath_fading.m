% Design, analyze and test Wireless standards and evaluate the performance measurements such as
% BER, PER, BLER, throughput, capacity, ACLR, EVM for 4G and 5G using Matlab.

clc;
clear;
close all;

Name = input('Program Executed by :','s');

% Simulation parameters
numSamples = 1000; % Number of samples
numPaths = 3; % Number of multipath paths
fadePower = 0.5; % Fading power

% Generate Rayleigh fading channel coefficients
h = sqrt(fadePower/2)*(randn(numPaths, numSamples) + 1i*randn(numPaths, numSamples));

% Generate transmitted signal
txSignal = randn(1, numSamples) + 1i*randn(1, numSamples);

% Simulate multipath fading channel
rxSignal = zeros(1, numSamples);

for path = 1:numPaths
    rxSignal = rxSignal + h(path, :) .* txSignal;
end

% Plot the transmitted and received signals
t = 1:numSamples;
figure;

subplot(2,1,1);
plot(t, real(txSignal), 'b', t, imag(txSignal), 'r');
title('Transmitted Signal');
legend('In-phase', 'Quadrature');
xlabel('Time');
ylabel('Amplitude');

subplot(2,1,2);
plot(t, real(rxSignal), 'b', t, imag(rxSignal), 'r');
title('Received Signal');
legend('In-phase', 'Quadrature');
xlabel('Time');
ylabel('Amplitude');

merge=strcat(Name,'-',datestr(now,30));
sub_label(merge); % need to include in working directory
print(merge,'-dpdf')