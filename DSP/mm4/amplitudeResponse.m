% Define the coefficients of the numerator and denominator
numerator = 0.0317 * [1 3 3 1];
denominator = [1 -1.4590 0.9104 -0.1978];

% Frequency response
[H, w] = freqz(numerator, denominator, 512);

% Plot magnitude response
figure;
plot(w/pi, 20*log10(abs(H)));
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
title('Amplitude Response');
