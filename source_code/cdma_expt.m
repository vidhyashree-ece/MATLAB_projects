clc;
clear;
close all;

% Parameters
N = 100;                 % Number of bits per user
SNR = 15;                % Signal-to-Noise Ratio in dB
users = 2;               % Number of users

Name = input('Program Executed by :','s');

% Generate random binary data for each user
data_user1 = randi([0, 1], 1, N) * 2 - 1;  % BPSK (-1, +1) for user 1
data_user2 = randi([0, 1], 1, N) * 2 - 1;  % BPSK (-1, +1) for user 2

% Generate unique spreading codes (orthogonal codes) for each user
code_user1 = randi([0, 1], 1, N) * 2 - 1;  % Code for user 1
code_user2 = randi([0, 1], 1, N) * 2 - 1;  % Code for user 2

% Spread the data using spreading codes
spread_user1 = data_user1 .* code_user1;
spread_user2 = data_user2 .* code_user2;

% Combine the signals (superposition) to simulate channel transmission
combined_signal = spread_user1 + spread_user2;

% Add noise to the combined signal
noisy_signal = awgn(combined_signal, SNR, 'measured');

% Despreading (decoding) the signal for each user
received_user1 = noisy_signal .* code_user1;
received_user2 = noisy_signal .* code_user2;

% Integrate and detect the signal by summing the despread signals
% over the length of the spreading code
detected_user1 = sign(sum(reshape(received_user1, [], N), 1));
detected_user2 = sign(sum(reshape(received_user2, [], N), 1));

% Adjust the plot length to the actual length of decoded signal
plot_length = min(length(detected_user1), 50);

% Plotting
figure;

% User 1 Data and Decoded Signal
subplot(6,1,1);
stem(data_user1(1:plot_length), 'filled');
title('Original Data for User 1');
xlabel('Bit Index');
ylabel('Amplitude');
grid on;

subplot(6,1,2);
stem(code_user1(1:plot_length), 'filled');
title('spreading code for User 1');
xlabel('Bit Index');
ylabel('Amplitude');
grid on;

subplot(6,1,3);
stem(detected_user1(1:plot_length), 'filled');
title('Decoded Data for User 1');
xlabel('Bit Index');
ylabel('Amplitude');
grid on;

% User 2 Data and Decoded Signal
subplot(6,1,4);
stem(data_user2(1:plot_length), 'filled');
title('Original Data for User 2');
xlabel('Bit Index');
ylabel('Amplitude');
grid on;

subplot(6,1,5);
stem(code_user2(1:plot_length), 'filled');
title('Spreading code  for User 1');
xlabel('Bit Index');
ylabel('Amplitude');
grid on;

subplot(6,1,6);
stem(detected_user2(1:plot_length), 'filled');
title('Decoded Data for User 2');
xlabel('Bit Index');
ylabel('Amplitude');
grid on;

merge=strcat(Name,'-CDMA-',datestr(now,30));
sub_label(merge); % need to include in working directory
print(merge,'-dpdf')