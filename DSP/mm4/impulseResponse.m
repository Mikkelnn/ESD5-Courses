% Define the coefficients of the numerator and denominator
numerator = 0.0317 * [1 3 3 1];
denominator = [1 -1.4590 0.9104 -0.1978];

% Impulse response
impulse_response = filter(numerator, denominator, [1; zeros(100,1)]);

% Plot impulse response
figure;
stem(impulse_response);
title('Impulse Response');
