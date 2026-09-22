clc, clear, close all

hover_telemetry = readtable("D:\Downloads\wed-23-hover-telemetry.csv");
hover_mocap = readtable("D:\Downloads\wed-23-hover-mocap.csv");
hover_radio = readtable("D:\Downloads\wed-23-hover-radio.csv");
circle_telemetry = readtable("D:\Downloads\wed-23-circle-telemetry.csv");
circle_radio = readtable("D:\Downloads\wed-23-circle-radio.csv");
circle_mocap = readtable("D:\Downloads\wed-23-circle-mocap.csv");

% Pitch acceleration
J = 0.003456;
l = 1.2; %I think l, the distance between propeller to propeller, should be 0.120m instead of 1.2m
pitch_values_h = [];

for i = 1:length(hover_telemetry.time)
    t_h = hover_telemetry.time(i);
    q_h = hover_telemetry.pitchrate(i);
    f_1_h = hover_telemetry.thrust1(i);
    f_2_h = hover_telemetry.thrust2(i);
    f_3_h = hover_telemetry.thrust3(i);
    f_4_h = hover_telemetry.thrust4(i);
    pitch_acc_i_h = (-(f_1_h+f_2_h)*l+(f_3_h+f_4_h)*l)/J;
    pitch_values_h = [pitch_values_h; t_h, q_h, pitch_acc_i_h];
end
pitch_table_h = array2table(pitch_values_h,"VariableNames",{'Time','Pitch_rate','Pitch_acc'});

pitch_values_c = [];

for i = 1:length(circle_telemetry.time)
    t_c = circle_telemetry.time(i);
    q_c = circle_telemetry.pitchrate(i);
    f_1_c = circle_telemetry.thrust1(i);
    f_2_c = circle_telemetry.thrust2(i);
    f_3_c = circle_telemetry.thrust3(i);
    f_4_c = circle_telemetry.thrust4(i);
    pitch_acc_i_c = (-(f_1_c+f_2_c)*l+(f_3_c+f_4_c)*l)/J;
    pitch_values_c = [pitch_values_c; t_c, q_c, pitch_acc_i_c];
end
pitch_table_c = array2table(pitch_values_c,"VariableNames",{'Time','Pitch_rate','Pitch_acc'});

figure

subplot(2,1,1);
plot(hover_telemetry.time, hover_telemetry.pitchrate,'r-');
title("Time Vs Pitch Rate");
hold on;
plot(hover_radio.time,hover_radio.angvely,'b-');
grid on;
legend("q","q_{cmd}");
xlabel('Time (s)');
ylabel('Pitch Rate (rad/s)');

subplot(2,1,2);
plot(pitch_table_h.Time,pitch_table_h.Pitch_acc,'r-');
title("Time Vs Pitch Acceleration");
xlabel('Time (s)');
ylabel('Pitch Acceleration (rad/s^2)');
grid on;