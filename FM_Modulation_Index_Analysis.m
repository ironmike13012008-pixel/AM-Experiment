clc;
clear;
close all;

%% Input Parameters
Am = 2;          % Message amplitude (V)
fm = 500;        % Message frequency (Hz)

Ac = 1;          % Carrier amplitude
fc = 10000;      % Carrier frequency (Hz)

kf = 1000;       % Frequency sensitivity (Hz/V)

fs = 100000;     % Sampling frequency (Hz)
T = 0.02;        % Simulation time (s)

t = 0:1/fs:T;

%% Message Signal
m = Am*cos(2*pi*fm*t);

%% Frequency Deviation
delta_f = kf*Am;

%% Modulation Index
beta = delta_f/fm;

%% FM Signal
fm_signal = Ac*cos(2*pi*fc*t + beta*sin(2*pi*fm*t));

%% Time Domain Plots
figure;

subplot(2,1,1)
plot(t,m,'b','LineWidth',1.5)
grid on
xlabel('Time (s)')
ylabel('Amplitude')
title('Message Signal')

subplot(2,1,2)
plot(t,fm_signal,'r','LineWidth',1)
grid on
xlabel('Time (s)')
ylabel('Amplitude')
title('Frequency Modulated Signal')

%% FFT Analysis
N = length(fm_signal);

FM_fft = fft(fm_signal);

FM_mag = abs(fftshift(FM_fft))/N;

f = (-N/2:N/2-1)*(fs/N);

figure
plot(f,FM_mag,'LineWidth',1.5)
grid on
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Spectrum of FM Signal')

xlim([fc-10000 fc+10000])

%% Carson's Rule
BW = 2*(delta_f + fm);

%% Display Results

fprintf('\n');
fprintf('=====================================\n');
fprintf('        FM SIGNAL PARAMETERS\n');
fprintf('=====================================\n');

fprintf('Carrier Frequency      = %.0f Hz\n',fc);
fprintf('Message Frequency      = %.0f Hz\n',fm);
fprintf('Message Amplitude      = %.2f V\n',Am);
fprintf('Carrier Amplitude      = %.2f V\n',Ac);
fprintf('Frequency Sensitivity  = %.0f Hz/V\n',kf);

fprintf('\n');

fprintf('Frequency Deviation    = %.0f Hz\n',delta_f);
fprintf('Modulation Index (β)   = %.2f\n',beta);

fprintf('Bandwidth (Carson)     = %.0f Hz\n',BW);

fprintf('=====================================\n');