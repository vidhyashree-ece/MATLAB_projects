clc
clear;
close all;

disp('Enter Ur Name with Expt Name: Eg: Vidhya_DSSS')
Name=input('Name_Expt:','s');


% Parameters
N = 10;                   % Number of bits (Reduced for easier visualization)
samples_per_bit = 100;    % Number of samples per bit for continuous waveform
SNR = 15;                 % Signal-to-Noise Ratio in dB

% Time axis for one bit
t = linspace(0, 1, samples_per_bit); 

% Generate random binary data and map to BPSK (-1, +1)
data = randi([0, 1], N, 1) * 2 - 1;  

% Plotting
figure;

% Original Data Signal (Continuous waveform)
subplot(5,1,1);
d=repelem(data, samples_per_bit);
stairs(d, 'b', 'LineWidth', 1.5);
title('Original Data Signal (Continuous Waveform)');
xlabel('Time');
ylabel('Amplitude');
grid on;

% Generate PRN code as a continuous signal for one bit duration
prn_code = round(rand(1, samples_per_bit)) * 2 - 1;

%pseudo random sequence generation
subplot(5,1,2);
stairs(prn_code,'linewidth',2);
title('Pseudorandom bit sequence pr');
xlabel('Time');
ylabel('Amplitude');
grid on;

% DSSS Modulation
spread_signal = [];
for i = 1:N
    % Modulate each bit with the PRN code over the bit duration
    bit_signal = data(i) * prn_code;
    spread_signal = [spread_signal, bit_signal];  % Concatenate for continuous waveform
end


% Add noise to simulate transmission over a channel
received_signal = awgn(spread_signal, SNR, 'measured');

% DSSS Demodulation
despread_signal = [];
for i = 1:N
    % Extract one bit duration and multiply by PRN code to despread
    received_bit = received_signal((i-1)*samples_per_bit+1 : i*samples_per_bit);
    despread_bit = received_bit .* prn_code;
    despread_signal(i) = sum(despread_bit);  % Integrate over bit duration
end

% Decision on detected bits
detected_data = sign(despread_signal);

% Generate time axis for plotting
t_full = linspace(0, N, N * samples_per_bit);


% Spread Signal (DSSS Modulated Signal)
subplot(5,1,3);
plot(t_full, spread_signal, 'r');
title('Spread Signal (DSSS Modulation - Continuous Waveform)');
xlabel('Time');
ylabel('Amplitude');
grid on;

% Received Signal (With Noise)
subplot(5,1,4);
plot(t_full, received_signal, 'm');
title('Received Signal (With Noise)');
xlabel('Time');
ylabel('Amplitude');
grid on;

% Detected Data after Despreading
subplot(5,1,5);
stairs(repelem(detected_data, samples_per_bit), 'g', 'LineWidth', 1.5);
title('Detected Data after Despreading (Continuous Waveform)');
xlabel('Time');
ylabel('Amplitude');
grid on;

merge=strcat(Name,'-',datestr(now,30));
sub_label(merge); % need to include in working directory
print(merge,'-dpdf')