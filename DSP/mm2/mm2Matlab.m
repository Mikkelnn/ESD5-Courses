% MATLAB script to compute and plot the frequency response of a Z-transform

% Define the numerator and denominator coefficients of the transfer function H(z)
% Replace these coefficients with the ones for your system
num = [exp(-1)-exp(-3)];    % Example: numerator coefficients of H(z)
den = [1 -exp(-1)-exp(-3) exp(-1)*exp(-3)];   % Example: denominator coefficients of H(z)

% Number of frequency points for evaluation
n_freq_points = 512;

% Frequency range: from 0 to pi (normalized frequency, pi corresponds to Nyquist frequency)
w = linspace(0, pi, n_freq_points);  % Frequency vector

% Compute the frequency response using the freqz function
[H, w] = freqz(num, den, n_freq_points);

% Plot the magnitude response
figure;
subplot(2,1,1);
plot(w/pi, abs(H), 'LineWidth', 1.5);
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude');
title('Magnitude Response');
grid on;

% Plot the phase response
subplot(2,1,2);
plot(w/pi, angle(H), 'LineWidth', 1.5);
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Phase (radians)');
title('Phase Response');
grid on;

% Optional: Display poles and zeros of the transfer function
figure;
zplane(num, den);
title('Pole-Zero Plot');
