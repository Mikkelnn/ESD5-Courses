% Define the coefficients of the numerator and denominator
numerator = 0.0317 * [1 3 3 1];
denominator = [1 -1.4590 0.9104 -0.1978];

% Find the poles and zeros
[z, p, k] = tf2zpk(numerator, denominator);

% Plot pole-zero plot
figure;
zplane(z, p);
title('Pole-Zero Plot');
