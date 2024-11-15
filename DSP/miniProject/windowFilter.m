% Specifications
Fs = 4750*2*2;            % Sampling frequency in Hz
fc = 1000;            % 3dB cutoff frequency in Hz
f1 = 750;             % Frequency where gain should be -1dB
f2 = 1500;            % Frequency where gain should be -10dB
gain_1dB = -1;        % Desired gain at 750 Hz in dB
gain_10dB = -10;      % Desired gain at 1500 Hz in dB
num_taps = 11;       % Default filter order (number of taps)
filter_type = 'lowpass'; % Choose filter type: 'lowpass', 'highpass', 'bandpass', 'bandstop'
window_type = 'blackman'; % Window type: 'rectangular', 'hamming', 'hanning', 'blackman', 'kaiser'

% Filter parameters for sharper control
sharpness_factor = 1.5; % Factor to increase/decrease sharpness
transition_width = abs(f2 - f1) / Fs / sharpness_factor; % Adjusted transition width

% Set cutoff frequency and filter design parameters based on filter type
switch filter_type
    case 'lowpass'
        cutoff = fc / (Fs / 2);  % Normalized cutoff for lowpass
        fir1_type = 'LOW';          % No specific type argument needed for lowpass in fir1
    case 'highpass'
        cutoff = fc / (Fs / 2);  % Normalized cutoff for highpass
        fir1_type = 'HIGH';
    case 'bandpass'
        cutoff = [f1, f2] / (Fs / 2);  % Normalized band edges for bandpass
        fir1_type = 'BANDPASS';
    case 'bandstop'
        cutoff = [f1, f2] / (Fs / 2);  % Normalized band edges for bandstop
        fir1_type = 'STOP';
    otherwise
        error('Unsupported filter type. Choose lowpass, highpass, bandpass, or bandstop.');
end

% Choose the appropriate window function
switch window_type
    case 'rectangular'
        window = rectwin(num_taps);
    case 'hamming'
        window = hamming(num_taps);
    case 'hanning'
        window = hanning(num_taps);
    case 'blackman'
        window = blackman(num_taps);
    case 'kaiser'
        beta = 3.5;  % Beta value controls the trade-off between main lobe width and sidelobe level
        window = kaiser(num_taps, beta);
    otherwise
        error('Unsupported window type. Choose rectangular, hamming, hanning, blackman, or kaiser.');
end

% Design the FIR filter with the specified window and filter type
fir_coeffs = fir1(num_taps - 1, cutoff, fir1_type, window);

% Frequency response of the FIR filter
[H, w] = freqz(fir_coeffs, 1, 8000, Fs);

% Convert frequency response to dB scale
H_dB = 20 * log10(abs(H));

% Plot frequency response
figure;
plot(w, H_dB, 'DisplayName', 'FIR Filter Frequency Response');
hold on;
xline(fc, 'r--', 'DisplayName', '3dB Cutoff Frequency');
if strcmp(filter_type, 'bandpass') || strcmp(filter_type, 'bandstop')
    xline(f1, 'g--', 'DisplayName', 'Passband Start (f1)');
    xline(f2, 'm--', 'DisplayName', 'Passband End (f2)');
end
title(['FIR Filter Frequency Response with ', window_type, ' Window']);
xlabel('Frequency (Hz)');
ylabel('Gain (dB)');
legend();
grid on;
hold off;

% Display filter order and key specifications
fprintf('Filter order (taps): %d\n', num_taps);
fprintf('Cutoff frequency (3dB): %d Hz\n', fc);

% Find the approximate gain at specific frequencies
[~, idx_750] = min(abs(w - f1));  % Index closest to 750 Hz
[~, idx_1500] = min(abs(w - f2)); % Index closest to 1500 Hz
fprintf('Gain at 750 Hz (desired -1dB): %.2f dB\n', H_dB(idx_750));
fprintf('Gain at 1500 Hz (desired -10dB): %.2f dB\n', H_dB(idx_1500));
