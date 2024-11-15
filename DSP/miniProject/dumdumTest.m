% Specifications
fc = 0.2;                % Normalized cutoff frequency (3dB point), where 1 is Nyquist
transition_width = 0.05; % Normalized transition width (e.g., 0.05)
attenuation = 40;        % Desired stopband attenuation in dB

% Estimate the filter order using Kaiser formula
num_taps = ceil((attenuation - 8) / (2.285 * transition_width));
if mod(num_taps, 2) == 0
    num_taps = num_taps + 1; % Make the number of taps odd for a Type I FIR filter
end

% Design the FIR filter with a Hamming window
fir_coeffs = fir1(num_taps - 1, fc, 'low', hamming(num_taps));

% Frequency response of the FIR filter
[H, w] = freqz(fir_coeffs, 1, 8000);  % Response over a range of frequencies

% Convert frequency response to dB scale
H_dB = 20 * log10(abs(H));

% Plot frequency response
figure;
plot(w/pi, H_dB, 'DisplayName', 'FIR Filter Frequency Response');
hold on;
yline(-attenuation, 'r--', 'DisplayName', ['Stopband Attenuation (' num2str(attenuation) ' dB)']);
title('FIR Filter Frequency Response (Normalized)');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Gain (dB)');
legend();
grid on;
hold off;

% Display filter order and key specifications
fprintf('Estimated filter order (taps): %d\n', num_taps);
fprintf('Normalized cutoff frequency (3dB): %.2f\n', fc);
fprintf('Transition width: %.2f\n', transition_width);
fprintf('Stopband attenuation: %.2f dB\n', attenuation);
