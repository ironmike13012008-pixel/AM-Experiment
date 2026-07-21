clc;
clear;
close all;

%% Input Bit Sequence
input_bits = [1 0 0 1 1];

%% Convolutional Encoder
constraint_length = 3;
generator_polynomials = [7 5];

trellis = poly2trellis(constraint_length, generator_polynomials);

encoded_bits = convenc(input_bits, trellis);

%% Separate Encoded Bits into Pairs
encoded_pairs = reshape(encoded_bits,2,[])';

%% Create Encoded Output Strings

output_pair = cell(length(input_bits),1);

for i = 1:length(input_bits)

    output_pair{i} = sprintf('%d%d', ...
        encoded_pairs(i,1), encoded_pairs(i,2));

end

%% Create Result Table

Bit_Position = (1:length(input_bits))';

Input_Bit = input_bits';

Output_Encoded = output_pair;

T = table(Bit_Position, Input_Bit, Output_Encoded);

disp('==============================================');
disp('Convolutional Encoding Table');
disp('==============================================');
disp(T);

%% Plot Input and Encoded Sequences

figure('Name','Convolutional Encoder','NumberTitle','off');

subplot(2,1,1)

stairs(input_bits,'LineWidth',1.5)
ylim([-0.2 1.2])

title('Input Bit Sequence')
xlabel('Bit Position')
ylabel('Bit Value')
grid on

subplot(2,1,2)

stairs(encoded_bits,'LineWidth',1.5)
ylim([-0.2 1.2])

title('Encoded Output Bit Sequence')
xlabel('Encoded Bit Position')
ylabel('Bit Value')
grid on