% Clear workspace and command window
clear;
clc;

% Load the audio file
[audioSignal, fs] = audioread('audio_file.wav'); % Replace with your audio file
audioSignal = audioSignal(:, 1); % Use only one channel if stereo
audioSignal = audioSignal(1:fs*5); % Use the first 5 seconds of audio for testing

% Parameters
frameSize = 80; % Frame size for G.722 (in samples)
numFrames = floor(length(audioSignal) / frameSize);
subbandSamples = zeros(numFrames, frameSize);
encodedSignal = zeros(numFrames, frameSize);
decodedSignal = zeros(numFrames, frameSize);
numBits = 7; % Number of bits for quantization

% Create low-pass and high-pass filters for subband coding
[lowPass, highPass] = createFilters(fs);

% Main loop for frame processing
for i = 1:numFrames
    % Get current frame
    startIndex = (i-1) * frameSize + 1;
    endIndex = startIndex + frameSize - 1;
    currentFrame = audioSignal(startIndex:endIndex);
    
    % Subband coding (two subbands)
    lowBand = filter(lowPass, 1, currentFrame); % Low-frequency band
    highBand = filter(highPass, 1, currentFrame); % High-frequency band
    
    % Quantization (uniform quantization)
    lowBandQuant = quantize(lowBand, numBits);
    highBandQuant = quantize(highBand, numBits);
    
    % Store encoded signal: here we store them in separate rows
    encodedSignal(i, 1:frameSize/2) = lowBandQuant(1:frameSize/2)'; % Store low band
    encodedSignal(i, frameSize/2 + 1:frameSize) = highBandQuant(1:frameSize/2)'; % Store high band
    
    % Decoding (inverse quantization, reconstruction)
    decodedLow = inverseQuantize(lowBandQuant, numBits);
    decodedHigh = inverseQuantize(highBandQuant, numBits);
    
    % Reconstructing the original signal (simple summation)
    decodedSignal(i, :) = decodedLow + decodedHigh;
end

% Combine frames into a single signal
encodedSignal = reshape(encodedSignal', [], 1);
decodedSignal = reshape(decodedSignal', [], 1);

% Normalize the output signal
decodedSignal = decodedSignal / max(abs(decodedSignal));

% Plotting results
t = (0:length(audioSignal)-1) / fs;

figure;
subplot(3, 1, 1);
plot(t, audioSignal);
title('Original Audio Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 1, 2);
plot(t(1:length(encodedSignal)), encodedSignal);
title('Encoded Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 1, 3);
plot(t(1:length(decodedSignal)), decodedSignal);
title('Decoded Signal');
xlabel('Time (s)');
ylabel('Amplitude');

sgtitle('ITU-T G.722 Speech Encoder Simulation');

% Function to create low-pass and high-pass filters
function [lowPass, highPass] = createFilters(fs)
    % Design a low-pass filter
    [b, a] = butter(4, 0.3); % 4th-order Butterworth filter
    lowPass = b; % Coefficients for low-pass filter
    highPass = -b; % Coefficients for high-pass filter
    highPass(1) = highPass(1) + 1; % To maintain a unity gain
end

% Quantization function (uniform quantization)
function quantized = quantize(signal, numBits)
    % Define quantization levels
    qLevels = 2^numBits;
    minVal = min(signal);
    maxVal = max(signal);
    stepSize = (maxVal - minVal) / qLevels;
    
    % Quantize the signal
    quantized = round((signal - minVal) / stepSize);
    quantized = quantized * stepSize + minVal;
end

% Inverse quantization function
function signal = inverseQuantize(quantized, numBits)
    qLevels = 2^numBits;
    minVal = min(quantized);
    maxVal = max(quantized);
    stepSize = (maxVal - minVal) / qLevels;
    
    % Reconstruct the signal from quantized levels
    signal = quantized; % Inverse of quantization
end

