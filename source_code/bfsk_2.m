% BFSK Modulation and Demodulation

% Parameters
Fs = 1000;                % Sampling frequency
Tb = 0.1;                 % Bit duration
t = 0:1/Fs:Tb-1/Fs;      % Time vector for one bit
f0 = 100;                 % Frequency for binary '0'
f1 = 200;                 % Frequency for binary '1'
data = randi([0 1], 1, 10); % Random binary data (10 bits)

% BFSK Modulation
modulated_signal = []; % Initialize modulated signal

for i = 1:length(data)
    if data(i) == 0
        modulated_signal = [modulated_signal sin(2*pi*f0*t)];
    else
        modulated_signal = [modulated_signal sin(2*pi*f1*t)];
    end
end

% Plot modulated signal
figure;
subplot(3,1,1);
plot(modulated_signal);
title('BFSK Modulated Signal');
xlabel('Sample Number');
ylabel('Amplitude');

% Add noise to the modulated signal
SNR = 10; % Signal to Noise Ratio in dB
noisy_signal = awgn(modulated_signal, SNR, 'measured');

% Plot noisy signal
subplot(3,1,2);
plot(noisy_signal);
title('Noisy BFSK Signal');
xlabel('Sample Number');
ylabel('Amplitude');

% BFSK Demodulation
demodulated_data = []; % Initialize demodulated data

for i = 1:length(data)
    % Extract one bit duration
    segment = noisy_signal((i-1)*Fs*Tb+1 : i*Fs*Tb);
    % Compute energy for each frequency
    E0 = sum(segment .* sin(2*pi*f0*t))^2; % Energy for binary '0'
    E1 = sum(segment .* sin(2*pi*f1*t))^2; % Energy for binary '1'
    
    % Compare energies to decide
    if E0 > E1
        demodulated_data = [demodulated_data 0];
    else
        demodulated_data = [demodulated_data 1];
    end
end

% Plot demodulated data
subplot(3,1,3);
stem(demodulated_data, 'filled');
title('Demodulated Data');
xlabel('Bit Index');
ylabel('Decoded Bit');
ylim([-0.5 1.5]);

% Display results
disp('Original Data:');
disp(data);
disp('Demodulated Data:');
disp(demodulated_data);