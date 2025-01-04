% MATLAB script to plot v(t) and its FFT

% Define the time vector
Fs = 5000; % Sampling frequency (Hz)
T = 1 / Fs; % Sampling period (s)
L = 1000; % Number of samples
t = (0:L-1) * T; % Time vector from 0 to (L-1)*T

% Define the function
v_t = 0.5 * cos(200 * pi * t) + 1.0 * cos(400 * pi * t);

% carrier to modulate on
f_c = 2000; % carrier frequency [Hz]
v_ct = 10 * cos(f_c * 2*pi * t);

V_mt = v_ct .* v_t;

% Plot the time-domain signal
figure;
subplot(3, 1, 1); % Create a subplot for time-domain plot
plot(t, v_t, 'LineWidth', 1.5);
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Time-Domain Plot of v(t)');
xlim([0, 0.05]); % Zoom in on the first 10 ms for better visibility

% Compute the FFT
V_f = fft(v_t); % Compute FFT
P2 = abs(V_f / L); % Two-sided spectrum
P1 = P2(1:L/2+1); % Single-sided spectrum
P1(2:end-1) = 2 * P1(2:end-1); % Scale the amplitude
f = Fs * (0:(L/2)) / L; % Frequency vector

% Plot the frequency-domain signal
subplot(3, 1, 2); % Create a subplot for frequency-domain plot
plot(f, P1, 'LineWidth', 1.5);
grid on;
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Frequency-Domain Plot of v(t)');
xlim([0, 1000]); % Limit frequency axis to 0-1000 Hz

subplot(3, 1, 3); % Create a subplot for frequency-domain plot
plot(t, v_mt, 'LineWidth', 1.5);
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Time-Domain Plot of v_modulated(t)');
xlim([0, 0.05]); % Zoom in on the first 10 ms for better visibility

