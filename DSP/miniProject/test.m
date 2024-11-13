% Full MATLAB Script for Filter Design, Noisy Signal Generation, and Testing

% Filter specifications
N = 25;            % Filter length
M = floor (N/2) + 1;
MN = (M/3);
fs = 4900;       % Sampling frequency in Hz
fp = 1000;        % Passband frequency in Hz
alpha = (N - 1) / 2;  % Phase shift
l = fs/N

% Normalized frequency
f_normalized = (0:N-1) * fs / N;

% Desired frequency response H(k) (low-pass)
H = zeros(1, N);
M = floor(N/2) + 1;
for k = 1:N
    if k < ceil(MN)
        H(k) = 1;  % Passband
    else
        H(k) = 0;  % Stopband
    end
end
% Apply adjustments to H as per original code
H(ceil(MN)+2) = 0.01;
H(ceil(MN)+1) = 0.200;
H(ceil(MN)) = 0.650;
H

% Compute impulse response h(n)
h = zeros(1, N);  % Preallocate the impulse response array
for n = 0:N-1
    sum_term = 0;
    for k = 1:(N/2 - 1)
        sum_term = sum_term + 2 * abs(H(k + 1)) * cos(2 * pi * k * (n - alpha) / N);
    end
    h(n + 1) = (1 / N) * (sum_term + H(1));
end

% Display filter coefficients
%disp('Filter Coefficients h(n):');
%disp(h);

% Generate a noisy input signal for testing
duration = 0.05; % Signal duration in seconds
x_noisy = generateNoisySignal(fs, duration);

% Apply the filter to the noisy input signal
y_filtered = conv(x_noisy, h, 'same'); % Convolve and keep the same length

% Plot results
t = (0:length(x_noisy)-1) / fs;  % Time vector for plotting

% Time vector for smoother plotting with more points
t_high_res = linspace(0, duration, length(x_noisy) * 5); % Increase to 5x resolution
x_noisy_interp = interp1(t, x_noisy, t_high_res, 'spline'); % Interpolated noisy signal

% Plot original noisy signal with high-resolution time vector
subplot(3,1,1);
plot(t_high_res, x_noisy_interp);
title('Noisy Input Signal with 500 Hz Signal and High-Frequency Noise Filter 2');
xlabel('Time (s)');
ylabel('Amplitude');

% Time vector for smoother plotting with more points
t_high_res = linspace(0, duration, length(x_noisy) * 5); % Increase to 5x resolution
y_filtered_interp = interp1(t, y_filtered, t_high_res, 'spline'); % Interpolated filtered signal

% Plot filtered signal with high-resolution time vector
subplot(3,1,2);
plot(t_high_res, y_filtered_interp);
title('Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Frequency response of the filter
fftSize = (1024);
H_freq = fft(h, fftSize);  % High resolution for smooth plot
f = (0:(fftSize-1)) * fs / fftSize; % Frequency vector

% Compute magnitude in dB
h_freqDB = mag2db(abs(H_freq));

subplot(3,1,3);
plot(f, h_freqDB);
title('Filter Frequency Response in dB |H(f)|');
xlabel('Frequency (Hz)');
ylabel('|H(f)| in dB');
xlim([0 fs/2]);
grid on;

% Helper function: Generate a noisy test signal with 100 Hz sine wave and high-frequency noise
function x_noisy = generateNoisySignal(fs, duration)
    % Parameters for the signal components
    f_passband = 500;             % Clear signal frequency in the passband (e.g., 100 Hz)
    amplitude_passband = 1;       % Amplitude of the passband component
    
    % Generate time vector based on duration and sampling frequency
    t = 0:1/fs:duration;
    
    % Create passband component (clean 100 Hz sine wave)
    signal_passband = amplitude_passband * sin(2 * pi * f_passband * t);
    
    % Generate high-frequency noise (frequencies above 1500 Hz)
    high_freqs = [1000 1500 2000 2500 100 ]; % Frequencies in the stopband
    %noise = 0.3 * randn(size(t));  % Initialize with Gaussian noise
    noise = 0;

    for f_noise = high_freqs
        noise = noise + 0.5 * sin(2 * pi * f_noise * t); % Add each high-frequency component
    end
    
    % Combine the passband signal with the high-frequency noise
    x_noisy = signal_passband + noise;
    
    % Plot the noisy signal for visualization
    %figure;
    %plot(t, x_noisy);
    %title('Noisy Input Signal with High-Frequency Noise');
    %xlabel('Time (s)');
    %ylabel('Amplitude');
end
