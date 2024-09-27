% Define the numerator and denominator of G(s)
num = [1 2 4];  % Coefficients for s^2 + 2s + 4
den = conv([1 0], conv([1 4], conv([1 6], [1 1.4 1])));  % s * (s+4) * (s+6) * (s^2 + 1.4s + 1)

% Create the transfer function G(s)
G = tf(num, den);

% Plot the root locus
figure;
rlocus(G);
title('Root Locus of the System');

% Display the transfer function for reference
disp('Transfer function G(s):');
G

% Find the gain K that gives stability by analyzing the root locus
% The K values can be estimated by examining the plot interactively

K = rlocfind(G);
disp(['The selected value of K is: ', num2str(K)]);
