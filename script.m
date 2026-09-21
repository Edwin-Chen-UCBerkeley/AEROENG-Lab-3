clc, clear, close all

addpath(genpath('data')); %Adds relative file path of project resources
fileInfo = struct2table(dir("data/*.csv")); %Creates an array of each file's info

for i = 1:length(fileInfo.name)
    dataFlight{i} = readtable(string(fileInfo.name(i))); %Generates a table for each .csv file that was read earlier
end

%Task 8
figure
x = [dataFlight{6}.time, dataFlight{6}.pitchrate];
y = [dataFlight{5}.time, dataFlight{5}.angvely];
plot(x(:,1), x(:,2), y(:,1), y(:,2));
xlabel("Time (s)");
ylabel("Pitch Rate (º/s)");
title("Measured vs. Commanded Pitch Rate");
legend(["Measured" "Commanded"]);



