clc;
clear;
close all;

% Parameters
Am = 1;
fm = 500;
Ac = 5;
fc = 5000;

% Sampling Frequency
fs = 20*fc;

% Time Vector
t = 0:1/fs:4/fm;

% Message Signal
m = Am*sin(2*pi*fm*t);

% Carrier Signal
c = Ac*sin(2*pi*fc*t);

% Modulation Index
mu = Am/Ac;

% AM Signal
am = Ac*(1 + mu*sin(2*pi*fm*t)).*sin(2*pi*fc*t);

% Envelope Detection
dem = abs(hilbert(am));
dem = dem - mean(dem);

% FFT
N = length(am);
f = linspace(-fs/2, fs/2, N);
AM_FFT = abs(fftshift(fft(am)))/N;

% Sideband Frequencies
USB = fc + fm;
LSB = fc - fm;

% Power Calculation
Pc = Ac^2/2;
Psb = (mu^2*Pc)/4;

% Display Graphs
figure('Name','AM Modulation','NumberTitle','off');

subplot(3,2,1)
plot(t,m)
title('Message Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on

subplot(3,2,2)
plot(t,c)
title('Carrier Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on

subplot(3,2,3)
plot(t,am)
title('AM Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on

subplot(3,2,4)
plot(t,dem)
title('Demodulated Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on

subplot(3,2,5)
plot(f,AM_FFT)
xlim([fc-3*fm fc+3*fm])
title('Frequency Spectrum')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
grid on

subplot(3,2,6)
bar([Pc Psb Psb])
set(gca,'XTickLabel',{'Carrier','USB','LSB'})
title('Power Distribution')
ylabel('Power (W)')
grid on

% Results
fprintf('Modulation Index (mu) = %.2f\n', mu);
fprintf('Upper Sideband (USB) = %d Hz\n', USB);
fprintf('Lower Sideband (LSB) = %d Hz\n', LSB);
fprintf('Carrier Power (Pc) = %.2f W\n', Pc);
fprintf('Each Sideband Power (Psb) = %.3f W\n', Psb);