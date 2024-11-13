% Main script

% Filter specifications
N = 25;                     % Filter length
M = floor(N / 2) + 1;
fs = 4900;                 % Sampling frequency in Hz
fp = 1000;                 % Passband frequency in Hz
alpha = (N - 1) / 2;       % Phase shift
l = fs / N;

% Normalized frequency
f_normalized = (0:N-1) / N;  % Normalized frequency from 0 to 1

% Desired frequency response H(k) (low-pass)
H = zeros(1, N);
for k = 1:N
    if k < 12
        H(k) = 1;          % Passband
    else
        H(k) = 0;          % Stopband
    end
end

% Manually adjust some values for specific filter response
%H(5) = 0.0037;
%H(4) = 0.123;
%H(3) = 0.601;
H

M = 3;
tw = (M + 1) * fs / N;

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

% Compute frequency response for plotting
H_freq = fft(h, 512);            % Use a high number of points for smooth frequency plot
f_normalized_plot = (0:511) / 512;  % Normalized frequency vector for plotting

% Compute the magnitude in dB and amplitude
h_freqDB = mag2db(abs(H_freq));  % dB scale
h_freq_amp = abs(H_freq);        % Amplitude scale

% Choose which plots to display
showImpulseResponse = false;
showMagnitudeDB = true;
showMagnitudeAmplitude = true;

% Display the selected plots
if showImpulseResponse
    plotImpulseResponse(h, N);
end

if showMagnitudeDB
    plotMagnitudeDB(f_normalized_plot, h_freqDB);
end

if showMagnitudeAmplitude
    plotMagnitudeAmplitude(f_normalized_plot, h_freq_amp);
end

% Function definitions
function plotImpulseResponse(h, N)
    figure; % Open a new figure window
    stem(0:N-1, h, 'filled');
    title('Impulse Response h(n)');
    xlabel('n');
    ylabel('h(n)');
end

function plotMagnitudeDB(f_normalized, h_freqDB)
    figure; % Open a new figure window
    plot(f_normalized, h_freqDB);
    title('Magnitude of Frequency Response in dB |H(f)|');
    xlabel('Normalized Frequency (×π rad/sample)');
    ylabel('|H(f)| in dB');
    xlim([0 0.5]);  % Limit the x-axis to the Nyquist frequency in normalized units (0.5)
    grid on;
end

function plotMagnitudeAmplitude(f_normalized, h_freq_amp)
    figure; % Open a new figure window
    plot(f_normalized, h_freq_amp);
    title('Magnitude of Frequency Response |H(f)| in Amplitude');
    xlabel('Normalized Frequency (×π rad/sample)');
    ylabel('|H(f)| in Amplitude');
    xlim([0 0.5]);  % Limit the x-axis to the Nyquist frequency in normalized units (0.5)
    grid on;
end
