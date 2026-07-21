clc;
clear;
close all;

%% Parameters
N = 1000;                 % Number of transmitted bits
SNR = 5;                  % Signal-to-Noise Ratio (dB)

%% Generate Random Binary Data
data = randi([0 1],N,1);

%% Ensure Even Number of Bits
if mod(N,2)~=0
    data = [data;0];
    N = N + 1;
end

%% Group Bits into Pairs
bit_pairs = reshape(data,2,[])';

%% QPSK Mapping (Gray Coding)

qpsk_symbols = zeros(size(bit_pairs,1),1);

for k = 1:size(bit_pairs,1)

    if isequal(bit_pairs(k,:),[0 0])
        qpsk_symbols(k) = (1+1i)/sqrt(2);

    elseif isequal(bit_pairs(k,:),[0 1])
        qpsk_symbols(k) = (-1+1i)/sqrt(2);

    elseif isequal(bit_pairs(k,:),[1 1])
        qpsk_symbols(k) = (-1-1i)/sqrt(2);

    elseif isequal(bit_pairs(k,:),[1 0])
        qpsk_symbols(k) = (1-1i)/sqrt(2);
    end

end

%% Plot Ideal Constellation

figure('Name','QPSK Constellation Diagram','NumberTitle','off');

subplot(1,2,1)

scatter(real(qpsk_symbols),imag(qpsk_symbols),30,'filled')
hold on
xline(0,'k','LineWidth',1.5)
yline(0,'k','LineWidth',1.5)

grid on
axis equal

xlim([-1.5 1.5])
ylim([-1.5 1.5])

xlabel('In-Phase (I)')
ylabel('Quadrature (Q)')
title('Ideal QPSK Constellation')

%% Add AWGN Noise

rx_signal = awgn(qpsk_symbols,SNR,'measured');

%% Plot Noisy Constellation

subplot(1,2,2)

scatter(real(rx_signal),imag(rx_signal),15,'filled')
hold on
xline(0,'k','LineWidth',1.5)
yline(0,'k','LineWidth',1.5)

grid on
axis equal

xlim([-2 2])
ylim([-2 2])

xlabel('In-Phase (I)')
ylabel('Quadrature (Q)')
title(['Noisy QPSK Constellation (SNR = ',num2str(SNR),' dB)'])

%% Symbol Detection

detected_bits = zeros(length(rx_signal)*2,1);

for k = 1:length(rx_signal)

    I = real(rx_signal(k));
    Q = imag(rx_signal(k));

    if I>0 && Q>0
        bits = [0 0];

    elseif I<0 && Q>0
        bits = [0 1];

    elseif I<0 && Q<0
        bits = [1 1];

    else
        bits = [1 0];
    end

    detected_bits(2*k-1:2*k) = bits;

end

%% BER Calculation

num_errors = sum(data ~= detected_bits);

BER = num_errors/N;

%% Display Results

fprintf('\n=====================================\n');
fprintf('QPSK MODULATION RESULTS\n');
fprintf('=====================================\n');

fprintf('Number of Transmitted Bits = %d\n',N);
fprintf('Signal-to-Noise Ratio      = %d dB\n',SNR);
fprintf('Number of Bit Errors       = %d\n',num_errors);
fprintf('Bit Error Rate (BER)       = %.6f\n',BER);

fprintf('=====================================\n');