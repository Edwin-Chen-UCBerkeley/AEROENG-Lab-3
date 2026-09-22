clc, clear, close all

addpath(genpath('data')); %Adds relative file path of project resources
fileInfo = struct2table(dir("data/*.csv")); %Creates an array of each file's info

for i = 1:length(fileInfo.name)
    dataFlight{i} = readtable(string(fileInfo.name(i))); %Generates a table for each .csv file that was read earlier
end

%Index of dataFlight{i}
% 1. {'wed-23-circle-mocap.csv'    }
% 2. {'wed-23-circle-radio.csv'    }
% 3. {'wed-23-circle-telemetry.csv'}
% 4. {'wed-23-hover-mocap.csv'     }
% 5. {'wed-23-hover-radio.csv'     }
% 6. {'wed-23-hover-telemetry.csv' }

%Task 8
figure
x = [dataFlight{6}.time, dataFlight{6}.pitchrate]; %IMU measured data
y = [dataFlight{5}.time, dataFlight{5}.angvely]; %Commanded data from radio
plot(x(:,1), x(:,2), y(:,1), y(:,2));
xlim([9,17]);
xlabel("Time (s)");
ylabel("Pitch Rate (rad/s)");
title("Time vs. Pitch Rate");
legend(["Measured" "Commanded"]);

figure
x = dataFlight{6}.time;
y = [dataFlight{6}.thrust1 dataFlight{6}.thrust2 dataFlight{6}.thrust3 dataFlight{6}.thrust4];
plot(x, y);
xlim([9,17]);
xlabel("Time (s)");
ylabel("Thrust (N)");
title("Time vs. Motor Thrust");
legend(["Thrust 1" "Thrust 2" "Thrust 3" "Thrust 4"]);

%Reverse engineer pitch acceleration
massMoment = 0.003456; %in kg•m^2
propellerDistance = 0.12; %in meters

figure
x = dataFlight{6}.time;
y = -(propellerDistance / (2 * massMoment)) .* (dataFlight{6}.thrust1 + dataFlight{6}.thrust2 - dataFlight{6}.thrust3 - dataFlight{6}.thrust4);
plot(x, y);
%xlim([9,17]);
xlabel("Time (s)");
ylabel("Pitch Acceleration (rad/s^2)");
title("Time vs. Pitch Acceleration");




