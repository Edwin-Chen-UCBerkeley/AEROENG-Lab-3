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
%subplot(2,1,1);
figure
x = [dataFlight{6}.time, dataFlight{6}.pitchrate]; %IMU measured data
y = [dataFlight{5}.time, dataFlight{5}.angvely]; %Commanded data from radio
plot(x(:,1), x(:,2), y(:,1), y(:,2));
xlabel("Time (s)");
ylabel("Pitch Rate (º/s)");
title("Measured vs. Commanded Pitch Rate");
legend(["Measured" "Commanded"]);

%subplot(2,1,2);
figure
x = dataFlight{6}.time;
y = [dataFlight{6}.thrust1 dataFlight{6}.thrust2 dataFlight{6}.thrust3 dataFlight{6}.thrust4];
plot(x, y);
xlabel("Time (s)");
ylabel("Thrust (N)");
title("Motor Thrust");
legend(["Thrust 1" "Thrust 2" "Thrust 3" "Thrust 4"]);






