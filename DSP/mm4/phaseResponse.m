% Define the coefficients of the numerator and denominator
numerator = 0.0317 * [1 3 3 1];
denominator = [1 -1.4590 0.9104 -0.1978];

% Frequency response
[H, w] = freqz(numerator, denominator, 512);

% Phase response
figure;
plot(w/pi, angle(H));
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Phase (radians)');
title('Phase Response');
