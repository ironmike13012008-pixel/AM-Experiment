clc;
clear;
close all;

Am = 1;
Ac = 1;
fm = 5;
fc = 50;
beta = 5;
kp = 5;
fs = 1000;

t = 0:1/fs:1;

m = Am*cos(2*pi*fm*t);                 % Message signal
c = Ac*cos(2*pi*fc*t);                 % Carrier signal
fm_sig = Ac*cos(2*pi*fc*t + beta*sin(2*pi*fm*t)); % FM signal

% Frequency Spectrum
N = length(fm_sig);
f = linspace(-fs/2, fs/2, N);
FM_FFT = abs(fftshift(fft(fm_sig)))/N;

figure;

subplot(4,1,1)
plot(t,m)
title('Message Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on

subplot(4,1,2)
plot(t,c)
title('Carrier Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on

subplot(4,1,3)
plot(t,fm_sig)
title('FM Signal')
xlabel('Time (s)')
ylabel('Amplitude')
grid on

subplot(4,1,4)
plot(f,FM_FFT)
title('Frequency Spectrum of FM Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
grid on