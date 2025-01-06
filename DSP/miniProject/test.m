% Filter specifications
N = 25;            % Filter length Husk at det skal være ulige her
MN = (5);
fs = 4900;       % Sampling frequency in Hz
fp = 1000;         % Passband frequency in Hz
alpha = (N - 1) / 2;  % Phase shift
l = fs / N;

% Desired frequency response H(k) (low-pass)
H = zeros(1, N);
for k = 1:N
    if k < ceil(MN)
        H(k) = 1;  % Passband
    else
        H(k) = 0;  % Stopband
    end
end
H(ceil(MN) + 2) = 0.01;
H(ceil(MN) + 1) = 0.200;
H(ceil(MN)) = 0.650;

% Compute impulse response h(n)
h = zeros(1, N);  % Preallocate the impulse response array
for n = 0:N-1
    sum_term = 0;
    for k = 1:(N/2 - 1)
        sum_term = sum_term + 2 * abs(H(k + 1)) * cos(2 * pi * k * (n - alpha) / N);
    end
    h(n + 1) = (1 / N) * (sum_term + H(1));
end

% Generate a noisy input signal for testing
duration = 0.05; % Signal duration in seconds
x_noisy = generateNoisySignal(fs, duration);

% Apply the filter to the noisy input signal
y_filtered = conv(x_noisy, h, 'same'); % Convolve and keep the same length

% Compute FFT of noisy (unfiltered) signal
fftSize = 2048*2; % High resolution for frequency analysis
x_noisy_fft = fft(x_noisy, fftSize);  % FFT of the noisy signal
x_noisy_fft = abs(x_noisy_fft(1:fftSize/2 + 1)) / length(x_noisy); % Normalize and take positive frequencies
x_noisy_fft(2:end-1) = 2 * x_noisy_fft(2:end-1); % Double non-DC, non-Nyquist components
f_fft = (0:fftSize/2) * fs / fftSize; % Frequency vector for positive frequencies

% Compute FFT of filtered signal
y_filtered_fft = fft(y_filtered, fftSize); % FFT of the filtered signal
y_filtered_fft = abs(y_filtered_fft(1:fftSize/2 + 1)) / length(y_filtered); % Normalize and take positive frequencies
y_filtered_fft(2:end-1) = 2 * y_filtered_fft(2:end-1); % Double non-DC, non-Nyquist components

% Plot results
t = (0:length(x_noisy)-1) / fs;  % Time vector for plotting

% Time vector for smoother plotting with more points
t_high_res = linspace(0, duration, length(x_noisy) * 5); % Increase to 5x resolution
x_noisy_interp = interp1(t, x_noisy, t_high_res, 'spline'); % Interpolated noisy signal

% Plot original noisy signal with high-resolution time vector
subplot(4,1,1);
plot(t_high_res, x_noisy_interp);
title('Noisy Input Signal with High-Frequency Noise');
xlabel('Time (s)');
ylabel('Amplitude');

% Interpolate filtered signal for smoother plotting
y_filtered_interp = interp1(t, y_filtered, t_high_res, 'spline'); % Interpolated filtered signal

% Plot filtered signal with high-resolution time vector
subplot(4,1,2);
plot(t_high_res, y_filtered_interp);
title('Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot FFT of the noisy (unfiltered) signal
subplot(2,1,1);
plot(f_fft, x_noisy_fft);
title('FFT of Noisy (Unfiltered) Signal');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
xlim([0 fs/2]); % Nyquist frequency
grid on;

% Plot FFT of the filtered signal
subplot(2,1,2);
plot(f_fft, y_filtered_fft);
title('FFT of Filtered Signal');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
xlim([0 fs/2]); % Nyquist frequency
grid on;

% Helper function: Generate a noisy test signal with 500 Hz sine wave and high-frequency noise
function x_noisy = generateNoisySignal(fs, duration)
    % Parameters for the signal components
    f_passband = 500;             % Clear signal frequency in the passband (e.g., 500 Hz)
    amplitude_passband = 1;       % Amplitude of the passband component
    
    % Generate time vector based on duration and sampling frequency
    t = 0:1/fs:duration;
    
    % Create passband component (clean 500 Hz sine wave)
    signal_passband = amplitude_passband * sin(2 * pi * f_passband * t);
    
    % Generate high-frequency noise (frequencies above 1500 Hz)
    high_freqs = [1000 1500 2000 2500 100]; % Frequencies in the stopband
    noise = 0;

    for f_noise = high_freqs
        noise = noise + 0.5 * sin(2 * pi * f_noise * t); % Add each high-frequency component
    end
    
    % Combine the passband signal with the high-frequency noise
    x_noisy = signal_passband + noise;
end
