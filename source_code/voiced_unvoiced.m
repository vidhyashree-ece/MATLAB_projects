% Speech Signal Classification: Voiced vs Unvoiced
% This program reads an audio file and classifies segments as voiced or unvoiced.

% Clear workspace and command window
clear;
clc;

% Read the audio file
[audioSignal, fs] = audioread('file_example_WAV_2MG.wav'); % Replace with your audio file name
audioSignal = audioSignal(:, 1); % Use only one channel if stereo

% Define parameters
frameSize = 256; % Number of samples per frame
overlap = 128; % Number of overlapping samples
numFrames = floor((length(audioSignal) - frameSize) / (frameSize - overlap)) + 1;

% Initialize feature vectors
energy = zeros(numFrames, 1);
zeroCrossingRate = zeros(numFrames, 1);
averageMagnitude = zeros(numFrames, 1);

% Feature extraction
for i = 1:numFrames
    startIndex = (i - 1) * (frameSize - overlap) + 1;
    endIndex = startIndex + frameSize - 1;
    frame = audioSignal(startIndex:endIndex);
    
    % Calculate energy
    energy(i) = sum(frame.^2);
    
    % Calculate zero-crossing rate
    zeroCrossings = sum(abs(diff(sign(frame)))) / 2;
    zeroCrossingRate(i) = zeroCrossings / frameSize;
    
    % Calculate average magnitude
    averageMagnitude(i) = mean(abs(frame));
end

% Classify segments
voicedThreshold = 0.1; % Adjust threshold as needed
unvoicedThreshold = 0.01; % Adjust threshold as needed

classification = zeros(numFrames, 1);
for i = 1:numFrames
    if energy(i) > voicedThreshold && zeroCrossingRate(i) < unvoicedThreshold
        classification(i) = 1; % Voiced
    else
        classification(i) = 0; % Unvoiced
    end
end

% Visualization
time = (0:numFrames-1) * (frameSize - overlap) / fs;
figure;
subplot(3, 1, 1);
plot((1:length(audioSignal)) / fs, audioSignal);
title('Audio Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 1, 2);
plot(time, energy);
title('Energy');
xlabel('Time (s)');
ylabel('Energy');

subplot(3, 1, 3);
plot(time, zeroCrossingRate);
hold on;
plot(time, averageMagnitude, 'r');
title('Zero-Crossing Rate and Average Magnitude');
xlabel('Time (s)');
ylabel('Rate / Magnitude');
legend('Zero-Crossing Rate', 'Average Magnitude');

% Show classification results
disp('Frame Number  |  Classification (1=Voiced, 0=Unvoiced)');
disp('-----------------------------------------------------');
for i = 1:numFrames
   if classification(i)==1
       fprintf('%12d  |  Voiced\n' ,i);
   else 
       fprintf('%12d  |  Unvoiced\n' ,i); 
   end
end

