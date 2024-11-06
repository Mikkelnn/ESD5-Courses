% Parameters
ka = 0.5;              % Amplitude sensitivity
Ac = 10;               % Carrier amplitude in volts
fc = 2000;             % Carrier frequency in Hz
fs = 100000;           % Sampling frequency for accurate plot (in Hz)
t = 0:1/fs:0.01;       % Time vector (up to 10 ms)

% Modulating signal m(t)
m_t = ka*cos(200*pi*t) + cos(400*pi*t);

% AM Modulated Signal s(t)
s_t = Ac * (1 + ka * m_t) .* cos(2 * pi * fc * t);

% Plotting the AM modulated signal
figure;
subplot(2, 1, 1);
plot(t, s_t);
title('AM Modulated Signal s(t)');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([0, 0.01]);

% Spectrum of the AM modulated signal
S_f = fftshift(fft(s_t));               % Compute Fourier Transform
f = linspace(-fs/2, fs/2, length(S_f)); % Frequency vector

% Plotting the Spectrum
subplot(2, 1, 2);
plot(f, abs(S_f) / max(abs(S_f)));      % Normalized for better visualization
title('Spectrum of AM Modulated Signal');
xlabel('Frequency (Hz)');
ylabel('Normalized Magnitude');
xlim([-5000, 5000]);                    % Limit frequency range for clarity
grid on;
