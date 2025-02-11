% Clear workspace and command window
clear;
clc;

% Parameters
fs = 1000; % Sampling frequency (Hz)
t = 0:1/fs:1; % Time vector (1 second duration)

% Generate a clean signal (sine wave)
freq = 5; % Frequency of the clean signal (Hz)
cleanSignal = sin(2 * pi * freq * t);

% Generate noise (white Gaussian noise)
noisePower = 0.5; % Noise power
noise = sqrt(noisePower) * randn(size(t));

% Create a noisy signal
noisySignal = cleanSignal + noise;

% Estimate the power spectral density of the noisy signal
[Pxx, f] = pwelch(noisySignal, [], [], [], fs);

% Compute the power spectral density of the clean signal (approximation)
% Assuming a simple model where clean signal power is higher
cleanPower = var(cleanSignal); % Variance of clean signal
signalPower = cleanPower; % Using clean signal power as an estimate

% Compute the Wiener filter transfer function
H = (signalPower ./ (signalPower + noisePower)); % Wiener filter in frequency domain

% Apply the Wiener filter in the frequency domain
Y = fft(noisySignal); % FFT of the noisy signal
Y_filtered = H .* Y; % Apply Wiener filter

% Inverse FFT to get the filtered time domain signal
filteredSignal = ifft(Y_filtered, 'symmetric');

% Plotting results
figure;

% Original Clean Signal
subplot(3, 1, 1);
plot(t, cleanSignal, 'g', 'LineWidth', 1.5);
title('Original Clean Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Noisy Signal
subplot(3, 1, 2);
plot(t, noisySignal, 'r', 'LineWidth', 1.5);
title('Noisy Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Filtered Signal
subplot(3, 1, 3);
plot(t, filteredSignal, 'b', 'LineWidth', 1.5);
title('Filtered Signal Using Wiener Filter');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

title('Wiener Filter for Noise Reduction');

% Optional: Play the sounds for better visualization
sound(noisySignal, fs);
pause(1);
sound(filteredSignal, fs);