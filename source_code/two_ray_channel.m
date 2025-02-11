% To design a model of wireless communication systems using Matlab (Two ray channel and Okumura –Hata model)

clc;
clear;
close all;

Name = input('Program Executed by :','s');

frequency = 900e6; % Frequency in Hz
transmitterHeight = 50; % Transmitter height in meters
receiverHeight = 10; % Receiver height in meters
distance = 100:100:1000; % Distance between transmitter and receiver in meters

% Two-ray Channel Model
Pt = 1; % Transmitted power in Watts
Gt = 1; % Transmitter antenna gain
Gr = 1; % Receiver antenna gain
L = 1; % System loss

% Calculate received power using Two-ray channel model
Pr_two_ray = Pt * (Gt * Gr * (transmitterHeight * receiverHeight)^2) ./ (distance.^4 * L);

% Okumura-Hata Model
A = 69.55; % Model parameter
B = 26.16; % Model parameter
C = 13.82; % Model parameter
D = 44.9; % Model parameter
X = 6.55; % Model parameter
hb = 30; % Base station height in meters

% Calculate path loss using Okumura-Hata model
PL_okumura_hata = A + B * log10(distance) + C * log10(frequency/1e6) + D - X * log10(hb);

% Plotting
figure;
plot(distance, Pr_two_ray, 'b--', 'LineWidth', 2);
hold on;
plot(distance, PL_okumura_hata, 'r--', 'LineWidth', 2);
legend('Two-ray Channel Model', 'Okumura-Hata Model');
xlabel('Distance (m)');
ylabel('Received Power/Path Loss (dB)');
title('Wireless Communication System Modeling');
grid on;

merge=strcat(Name,'-',datestr(now,30));
sub_label(merge); % need to include in working directory
print(merge,'-dpdf')