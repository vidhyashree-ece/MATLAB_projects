% Clear workspace and command window
clear;
clc;

% Load the audio file (replace with your own audio file)
[audioSignal, fs] = audioread('file_example_WAV_2MG.wav'); % Ensure it's a suitable audio file
audioSignal = audioSignal(:, 1); % Use only one channel if stereo
audioSignal = audioSignal / max(abs(audioSignal)); % Normalize the audio signal

% Parameters
frameSize = 256; % Frame size for analysis
overlap = frameSize / 2; % 50% overlap
numCoeffs = 12; % Number of DCT coefficients

% Initialize arrays to store features
numFrames = floor((length(audioSignal) - frameSize) / overlap) + 1;
DCT_features = zeros(numFrames, numCoeffs);

% Feature extraction
for i = 1:numFrames
    % Define frame
    startIndex = (i-1) * overlap + 1;
    endIndex = startIndex + frameSize - 1;
    frame = audioSignal(startIndex:endIndex);
    
    % Extract DCT features
    dctCoeffs = dct(frame); % Apply DCT
    DCT_features(i, :) = dctCoeffs(1:numCoeffs)'; % Keep first numCoeffs coefficients
end

% Plotting DCT features
figure;
imagesc(DCT_features'); % Transpose for better visualization
colorbar;
title('DCT Features');
xlabel('Frame Index');
ylabel('DCT Coefficient Index');
axis xy; % Correct axis direction
grid on;

% Optional: Display audio signal
figure;
t = (0:length(audioSignal)-1) / fs;
plot(t, audioSignal);
title('Original Audio Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;


