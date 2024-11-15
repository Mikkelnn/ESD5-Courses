
% Filter specifications
N = 19;            % Filter length Husk at det skal være ulige her
fd = 250;
M = floor (N/2) + 1;
MN = (4);
fs = N*fd;       % Sampling frequency in Hz
fp = 1000;        % Passband frequency in Hz
alpha = (N - 1) / 2;  % Phase shift
l = fs/N

% Normalized frequency
f_normalized = (0:N-1) * fs / N;

% Desired frequency response H(k) (low-pass)
H = zeros(1, N);
for k = 1:N
    if k < ceil(MN)
        H(k) = 1;  % Passband
    else
        H(k) = 0;  % Stopband
    end
end
%disp('Hs size:');
H(ceil(MN)+3) = 0.178
H(ceil(MN)+2) = 0.388;
H(ceil(MN)+1) = 0.708;
H(ceil(MN)) = 0.891;
H

%M = 3;
%tw = (M+1)*fs/N;

% Compute h(n) using the formula provided
h = zeros(1, N);  % Preallocate the impulse response array

for n = 0:N-1
    sum_term = 0;
    for k = 1:((N-1)/2)
        sum_term = sum_term + 2 * abs(H(k + 1)) * cos(2 * pi * k * (n - alpha) / N);
    end
    h(n + 1) = (1 / N) * (sum_term + H(1));
end

% Display the filter coefficients
disp('Filter Coefficients h(n):');
disp(h);

% Assume variables `h`, `N`, and `fs` are defined in the workspace
H_freq = fft(h, 512);            % Use a high number of points for smooth frequency plot
f = (0:511) * fs / 512;          % Frequency vector for plotting

% Compute the magnitude in dB and amplitude
h_freqDB = mag2db(abs(H_freq));  % dB scale
h_freq_amp = abs(H_freq);        % Amplitude scale

% Choose which plots to display
showImpulseResponse = true;
showMagnitudeDB = true;
showMagnitudeAmplitude = true;


% Display the selected plots
if showImpulseResponse
    plotImpulseResponse(h, N);
end

if showMagnitudeDB
    plotMagnitudeDB(f, h_freqDB, fs);
end

if showMagnitudeAmplitude
    plotMagnitudeAmplitude(f, h_freq_amp, fs);
end

% Function definitions
function plotImpulseResponse(h, N)
    figure; % Open a new figure window
    stem(0:N-1, h, 'filled');
    title('Impulse Response h(n)');
    xlabel('n');
    ylabel('h(n)');
end

function plotMagnitudeDB(f, h_freqDB, fs)
    figure; % Open a new figure window
    plot(f, h_freqDB);
    title('Magnitude of Frequency Response in dB |H(f)|');
    xlabel('Frequency (Hz)');
    ylabel('|H(f)| in dB');
    xlim([0 fs/2]);  % Limit the x-axis to the Nyquist frequency (half the sampling rate)
    grid on;
end

function plotMagnitudeAmplitude(f, h_freq_amp, fs)
    figure; % Open a new figure window
    plot(f, h_freq_amp);
    title('Magnitude of Frequency Response |H(f)| in Amplitude');
    xlabel('Frequency (Hz)');
    ylabel('|H(f)| in Amplitude');
    xlim([0 fs/2]);  % Limit the x-axis to the Nyquist frequency (half the sampling rate)
    grid on;
end
