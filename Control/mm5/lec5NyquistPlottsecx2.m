% MATLAB Script for Problem 2

% Given parameters
wc = pi/4;     % Desired digital cutoff frequency (rad)
T = 1;         % Sample period (assume T = 1 for simplicity)

% Analog cutoff frequency
Omega_c = 2/T * tan(wc/2);  % Prewarp the cutoff frequency

% Bilinear transformation of H(s) -> H(z)
syms z
s = 2/T * (1 - z^-1) / (1 + z^-1);  % Bilinear transformation

% Analog transfer function H(s)
Hs = Omega_c / (s + Omega_c);

% Substitute s into H(s) to get H(z)
Hz = simplify(Hs);

% Display the digital transfer function H(z)
disp('Digital transfer function H(z):');
pretty(Hz)

% Convert the symbolic transfer function to a numerical one
[num, den] = numden(Hz);      % Get numerator and denominator
num = sym2poly(num);          % Convert symbolic to polynomial coefficients
den = sym2poly(den);          % Convert symbolic to polynomial coefficients

% Frequency response of the digital filter
freqz(num, den);

% Find 3dB cutoff frequency
[H, w] = freqz(num, den, 1024);  % Compute frequency response
H_dB = 20*log10(abs(H));         % Magnitude response in dB

% Plot the magnitude response in dB
figure;
plot(w/pi, H_dB);
title('Magnitude Response of the Digital Filter');
xlabel('Normalized Frequency (\times \pi rad/sample)');
ylabel('Magnitude (dB)');
grid on;

% Find the 3dB frequency
H_max = max(H_dB);           % Maximum magnitude
idx_3dB = find(H_dB <= H_max - 3, 1);  % Find first point where it drops by 3dB
f_3dB = w(idx_3dB) / pi;     % Normalized frequency

fprintf('The 3dB frequency is at %f*pi rad/sample\n', f_3dB);

