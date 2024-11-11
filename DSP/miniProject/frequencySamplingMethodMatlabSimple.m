
% Filter specifications
n= 15;
N = 13;            % Filter length
fs = 3300;       % Sampling frequency in Hz
fp = 1000;        % Passband frequency in Hz
alpha = (N - 1) / 2;  % Phase shift
l = fs/N

% Normalized frequency
f_normalized = (0:N-1) * fs / N;

% Desired frequency response H(k) (low-pass)
H = zeros(1, N);
for k = 1:N
    if k < 6
        H(k) = 1;  % Passband
    else
        H(k) = 0;  % Stopband
    end
end
%disp('Hs size:');
%H(7) = 0.0037;
%H(6)=0.123;
%H(5)=0.601;
H


% Compute h(n) using the formula provided
h = zeros(1, N);  % Preallocate the impulse response array

for n = 0:N-1
    sum_term = 0;
    for k = 1:(N/2 - 1)
        sum_term = sum_term + 2 * abs(H(k + 1)) * cos(2 * pi * k * (n - alpha) / N);
    end
    h(n + 1) = (1 / N) * (sum_term + H(1));
end

% Display the filter coefficients
disp('Filter Coefficients h(n):');
disp(h);

% Plot the impulse response
figure;
subplot(2, 1, 1);
stem(0:N-1, h, 'filled');
title('Impulse Response h(n)');
xlabel('n');
ylabel('h(n)');

% Calculate and plot the frequency response
H_freq = fft(h, 512);  % Use a high number of points for smooth frequency plot
f = (0:511) * fs / 512; % Frequency vector for plotting

% Compute the magnitude in dB
h_freqDB = mag2db(abs(H_freq));  % Take the magnitude before converting to dB

% Plot the magnitude in dB
subplot(2, 1, 2);
plot(f, h_freqDB);
title('Magnitude of Frequency Response in DB |H(f)|');
xlabel('Frequency (Hz)');
ylabel('|H(f)| in dB');
xlim([0 fs/2]);  % Limit the x-axis to the Nyquist frequency (half the sampling rate)
grid on;

