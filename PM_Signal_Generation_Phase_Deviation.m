clc;
clear;
close all;

%% Message Signal Parameters
Am = 1;              % Message amplitude (V)
fm = 100;            % Message frequency (Hz)

%% Carrier Signal Parameters
Ac = 5;              % Carrier amplitude (V)
fc = 1000;           % Carrier frequency (Hz)

%% PM Parameters
kp = pi/2;           % Phase sensitivity (rad/V)

fs = 20*fc;          % Sampling frequency (Hz)

%% Time Vector
t = 0:1/fs:4/fm;

%% Message Signal
m = Am*sin(2*pi*fm*t);

%% Carrier Signal
c = Ac*cos(2*pi*fc*t);

%% Phase Modulated Signal
pm = Ac*cos(2*pi*fc*t + kp*m);

%% Phase Deviation
phase_dev = kp * Am;

%% PM Modulation Index
mp = phase_dev;

%% Display Results

fprintf('\n=====================================\n');
fprintf('PHASE MODULATION PARAMETERS\n');
fprintf('=====================================\n');

fprintf('Message Amplitude (Am)      = %.2f V\n',Am);
fprintf('Message Frequency (fm)      = %.0f Hz\n',fm);
fprintf('Carrier Amplitude (Ac)      = %.2f V\n',Ac);
fprintf('Carrier Frequency (fc)      = %.0f Hz\n',fc);
fprintf('Phase Sensitivity (kp)      = %.2f rad/V\n',kp);

fprintf('\nCalculated Values\n');
fprintf('-----------------------------\n');

fprintf('Phase Deviation             = %.2f radians\n',phase_dev);
fprintf('PM Modulation Index (mp)    = %.2f\n',mp);

%% Plotting

figure('Name','Phase Modulation','NumberTitle','off');

subplot(2,2,1)
plot(t,m,'LineWidth',1.5)
grid on
title('Message Signal')
xlabel('Time (s)')
ylabel('Amplitude (V)')

subplot(2,2,2)
plot(t,c,'LineWidth',1.5)
grid on
title('Carrier Signal')
xlabel('Time (s)')
ylabel('Amplitude (V)')

subplot(2,2,3)
plot(t,pm,'LineWidth',1.5)
grid on
title('Phase Modulated Signal')
xlabel('Time (s)')
ylabel('Amplitude (V)')

subplot(2,2,4)
bar(phase_dev)
grid on
title('Phase Deviation')
ylabel('Radians')
set(gca,'XTickLabel',{'PM Signal'})