% Clear workspace and command window
clear;
clc;

% Read audio file
[audioSignal, fs] = audioread('file_example_WAV_2MG.wav'); % Replace with your audio file name
audioSignal = audioSignal(:, 1); % Use only one channel if stereo

% Parameters
frameSize = 0.025; % Frame size in seconds
frameStep = 0.01;  % Step size in seconds
numFilters = 26;   % Number of Mel filter banks
numCoeffs = 13;    % Number of MFCC coefficients to keep
NFFT = 512;        % FFT size

% Pre-emphasis filter
preEmphasis = 0.97;
emphasizedSignal = filter([1 -preEmphasis], 1, audioSignal);

% Framing
frameLength = round(frameSize * fs);
frameStep = round(frameStep * fs);
numFrames = floor((length(emphasizedSignal) - frameLength) / frameStep) + 1;

frames = zeros(numFrames, frameLength);
for i = 1:numFrames
    startIndex = (i - 1) * frameStep + 1;
    endIndex = startIndex + frameLength - 1;
    frames(i, :) = emphasizedSignal(startIndex:endIndex) .* hamming(frameLength);
end

% Power Spectrum
powerFrames = abs(fft(frames, NFFT, 2)).^2 / NFFT;

% Mel-filter bank
lowFreq = 0;
highFreq = fs / 2;
melPoints = linspace(hz2mel(lowFreq), hz2mel(highFreq), numFilters + 2);
hzPoints = mel2hz(melPoints);
bin = floor((NFFT + 1) * hzPoints / fs);

filterBank = zeros(numFilters, NFFT / 2 + 1);
for m = 2:numFilters + 1
    for k = bin(m - 1):bin(m)
        filterBank(m - 1, k + 1) = (k - bin(m - 1)) / (bin(m) - bin(m - 1));
    end
    for k = bin(m):bin(m + 1)
        filterBank(m - 1, k + 1) = (bin(m + 1) - k) / (bin(m + 1) - bin(m));
    end
end

% Apply Mel filter bank to the power spectrum
melPower = powerFrames(:, 1:NFFT/2+1) * filterBank';

% Log energy
logMelPower = log(melPower + eps);

% Discrete Cosine Transform (DCT) to get MFCCs
mfcc = dct(logMelPower, [], 2);
mfcc = mfcc(:, 1:numCoeffs); % Keep first 13 coefficients

% Plot the MFCCs
figure;
imagesc(mfcc');
axis xy;
xlabel('Frame Index');
ylabel('MFCC Coefficients');
title('Mel-Frequency Cepstral Coefficients (MFCC)');

% Function to convert Hertz to Mel scale
function mel = hz2mel(hz)
    mel = 2595 * log10(1 + hz / 700);
end

% Function to convert Mel scale to Hertz
function hz = mel2hz(mel)
    hz = 700 * (10.^(mel / 2595) - 1);
end

