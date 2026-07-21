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

fs = 20*fc;          % Sampling frequency
t = 0:1/fs:4/fm;

%% Message Signal
m = Am*sin(2*pi*fm*t);

%% Carrier Signal
c = Ac*cos(2*pi*fc*t);

%% Phase Modulated Signal
pm = Ac*cos(2*pi*fc*t + kp*m);

%% Phase Deviation
beta = kp*Am;

%% FFT
N = length(pm);

PM_FFT = abs(fftshift(fft(pm)))/N;

f = (-N/2:N/2-1)*(fs/N);

%% Power Spectral Density

PSD = (abs(fftshift(fft(pm))).^2)/(N*fs);

%% Bandwidth Estimation

BW = 2*(beta+1)*fm;

%% Display Results

fprintf('\n=====================================\n');
fprintf('PSD ANALYSIS OF PM SIGNAL\n');
fprintf('=====================================\n');

fprintf('Message Frequency       = %.0f Hz\n',fm);
fprintf('Carrier Frequency       = %.0f Hz\n',fc);
fprintf('Phase Sensitivity       = %.2f rad/V\n',kp);
fprintf('Phase Deviation         = %.2f radians\n',beta);
fprintf('Estimated Bandwidth     = %.2f Hz\n',BW);

%% Plotting

figure('Name','PSD Analysis of PM Signal','NumberTitle','off');

subplot(2,2,1)
plot(t,m,'LineWidth',1.5)
grid on
title('Message Signal')
xlabel('Time (s)')
ylabel('Amplitude (V)')

subplot(2,2,2)
plot(t,pm,'LineWidth',1.5)
grid on
title('Phase Modulated Signal')
xlabel('Time (s)')
ylabel('Amplitude (V)')

subplot(2,2,3)
plot(f,PM_FFT,'LineWidth',1.5)
grid on
title('Frequency Spectrum of PM Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

subplot(2,2,4)
plot(f,PSD,'LineWidth',1.5)
grid on
title('Power Spectral Density')
xlabel('Frequency (Hz)')
ylabel('PSD')