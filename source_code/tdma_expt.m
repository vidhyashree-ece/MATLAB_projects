% To model and simulate TDMA for wireless communication

clc;
clear;
close all;

Name = input('Program Executed by :','s');

% Step 1: Define System Parameters
numUsers = 4;
timeSlotDuration = 1; % seconds
totalTimeSlots = 10;
channelGain = 0.8;

% Step 2: Generate User Traffic
userData = randi([0, 1], numUsers, totalTimeSlots);

% Step 3: Create Time Slots
timeSlots = linspace(0, timeSlotDuration*totalTimeSlots, totalTimeSlots);

% Step 4: Allocate Time Slots to Users
userSlots = mod(0:totalTimeSlots-1, numUsers) + 1;

% Step 5: Simulate Transmission
receivedData = zeros(numUsers, totalTimeSlots);

for slot = 1:totalTimeSlots
    for user = 1:numUsers
        if userSlots(slot) == user
            % Simulate transmission for the current user in the time slot
            transmittedData = userData(user, slot);
            % Simulate channel effects
            receivedData(user, slot) = transmittedData * channelGain;
        end
    end
end

% Step 6: Evaluate Performance Metrics (e.g., BER)
bitErrorRate = sum(sum(xor(receivedData, userData))) / (numUsers * totalTimeSlots);

% Step 7: Visualize Results
figure;
subplot(2, 1, 1);
stem(timeSlots, userData');
title('User Traffic');
xlabel('Time (s)');
ylabel('Data');
legend('User 1', 'User 2', 'User 3', 'User 4');

subplot(2, 1, 2);
stem(timeSlots, receivedData');
title('Received Data');
xlabel('Time (s)');
ylabel('Data');
legend('User 1', 'User 2', 'User 3', 'User 4');
disp(['Bit Error Rate: ', num2str(bitErrorRate)]);

merge=strcat(Name,'-TDMA-',datestr(now,30));
sub_label(merge); % need to include in working directory
print(merge,'-dpdf')