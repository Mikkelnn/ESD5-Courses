% MATLAB script for plotting x(t) and computing Fourier Series coefficients X[k]

%% Parameters
T = 2;            % Period of the signal
k_vals = -30:30;  % Range of k values for Fourier Series coefficients
t = linspace(-3, 3, 1000); % Time vector over [-3, 3]

%% Part (a): Define the periodic signal x(t)
% x(t) = e^(-t) for t in [-1, 1], extended periodically with period T = 2
x_t = @(t) exp(-mod(t + 1, T) + 1);

% Calculate x(t) values for plotting
x_t_vals = x_t(t);

% Plot x(t) over [-3, 3]
figure;
plot(t, x_t_vals, 'LineWidth', 1.5);
title('Plot of x(t) over t \in [-3, 3]');
xlabel('Time (t)');
ylabel('x(t)');
grid on;
legend('x(t) = e^{-t} (periodic)');

%% Part (b): Derive Fourier Series coefficients X[k]
% Fourier Series coefficient X[k] = (1/T) * integral from -1 to 1 of x(t) * exp(-j * pi * k * t) dt
X_k = zeros(size(k_vals)); % Initialize X[k] array
for i = 1:length(k_vals)
    k = k_vals(i);
    integrand = @(t) exp(-(1 + 1j * pi * k) * t);
    X_k(i) = (1 / T) * integral(integrand, -1, 1); % Compute X[k] via integral
end

%% Part (c): Plot |X[k]| for k \in [-30, 30]
X_k_magnitude = abs(X_k); % Magnitude of Fourier Series coefficients

% Plot |X[k]|
figure;
stem(k_vals, X_k_magnitude, 'filled', 'MarkerFaceColor', '#FFA500'); % Use hex color code for orange
title('Magnitude of Fourier Series Coefficients |X[k]| for k \in [-30, 30]');
xlabel('k');
ylabel('|X[k]|');
grid on;
legend('|X[k]|');
