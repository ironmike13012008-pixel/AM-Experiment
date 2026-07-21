clc;
clear;
close all;

%% PN Sequence Generation

% Degree of LFSR
m = 5;

% PN sequence length = 2^m - 1
pn_length = 2^m - 1;

% Generate PN sequence
pn_seq = comm.PNSequence( ...
    'Polynomial',[5 2 0], ...
    'SamplesPerFrame',pn_length, ...
    'InitialConditions',[1 1 1 1 1]);

pn = pn_seq();

%% Convert Logical to Bipolar

pn_bipolar = 2*pn - 1;

%% Processing Gain Calculation

PN_length = [7 15 31 63 127 255 511 1023];

PG_linear = PN_length;

PG_dB = 10*log10(PG_linear);

%% Display Processing Gain Table

T = table(PN_length',PG_dB', ...
    'VariableNames',{'PN_Length','Processing_Gain_dB'});

disp('=====================================')
disp('Processing Gain Table')
disp('=====================================')
disp(T)

%% Display Generated PN Sequence

disp('Generated PN Sequence')
disp(pn')

%% Plot

figure('Name','Spread Spectrum','NumberTitle','off');

subplot(2,1,1)

stem(pn_bipolar,'filled')
grid on
xlabel('Bit Position')
ylabel('Amplitude')
title('Generated PN Sequence')

subplot(2,1,2)

stem(PN_length,PG_dB,'filled')
grid on
xlabel('PN Sequence Length')
ylabel('Processing Gain (dB)')
title('Processing Gain vs PN Sequence Length')