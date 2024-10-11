
% Define the coefficients of the numerator and denominator
numerator = 0.0317 * [1 3 3 1];
denominator = [1 -1.4590 0.9104 -0.1978];

% Check specific frequencies
sampling_freq = 8000; % 8kHz
f1 = 1000 / (sampling_freq / 2);  % Normalized 1kHz
f2 = 750 / (sampling_freq / 2);   % Normalized 750Hz
f3 = 1500 / (sampling_freq / 2);  % Normalized 1500Hz

% Find amplitude at these points
mag_1khz = 20*log10(abs(freqz(numerator, denominator, f1)));
mag_750hz = 20*log10(abs(freqz(numerator, denominator, f2)));
mag_1500hz = 20*log10(abs(freqz(numerator, denominator, f3)));

fprintf('Gain at 1kHz: %f dB\n', mag_1khz);
fprintf('Gain at 750Hz: %f dB\n', mag_750hz);
fprintf('Gain at 1500Hz: %f dB\n', mag_1500hz);
