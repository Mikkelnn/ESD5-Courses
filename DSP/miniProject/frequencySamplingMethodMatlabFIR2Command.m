% Filter specifications
N = 15;            % Filter length (number of taps)
fs = 4800;       % Sampling frequency in Hz
fp = 1000;        % Passband frequency in Hz
f_nyquist = fs / 2;  % Nyquist frequency

% Normalize the frequencies to the Nyquist frequency
normalized_freq = [0, fp / f_nyquist, 1];  % 0 to normalized cutoff, then 1
magnitude = [1, 1, 0];  % Desired magnitude response (1 in passband, 0 in stopband)

% Use fir2 to design the filter
h_fir2 = fir2(N - 1, normalized_freq, magnitude);

% Display the filter coefficients
disp('Filter Coefficients using fir2:');
disp(h_fir2);

% Plot the impulse response
figure;
subplot(2, 1, 1);
stem(0:N-1, h_fir2, 'filled');
title('Impulse Response of Filter Designed with fir2');
xlabel('n');
ylabel('h(n)');

% Calculate and plot the frequency response in dB
H_freq = fft(h_fir2, 512);         % Use a high number of points for smooth frequency plot
f = (0:511) * fs / 512;            % Frequency vector for plotting
magnitude_dB = 20 * log10(abs(H_freq));  % Convert magnitude to dB

subplot(2, 1, 2);
plot(f, magnitude_dB);
title('Magnitude of Frequency Response |H(f)| in dB');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
xlim([0 fs/2]);                    % Limit the x-axis to the Nyquist frequency
grid on;
