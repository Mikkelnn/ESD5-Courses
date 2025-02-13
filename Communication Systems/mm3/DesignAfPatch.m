% Given constants
f_0 = 70e9; % Design frequency (mid-point of Bluetooth range), in Hz
c = 3e8; % Speed of light, m/s
epsilon_r = 2.2; % Dielectric constant for PP
h = 3e-3; % Substrate thickness, in meters
Z_edge = 240; % Impedance at edge, in ohms
Z_0 = 50; % Desired impedance, in ohms

% Step 1: Calculate the width W of the patch
W = (c / (2 * f_0)) * sqrt(2 / (epsilon_r + 1));

% Step 2: Calculate the effective dielectric constant (epsilon_eff)
epsilon_eff = (epsilon_r + 1) / 2 + (epsilon_r - 1) / 2 * (1 + 12 * h / W)^(-0.5);

% Step 3: Calculate the effective length L_eff
L_eff = c / (2 * f_0 * sqrt(epsilon_eff));

% Step 4: Calculate the length extension (Delta L)
delta_L = h * 0.412 * ((epsilon_eff + 0.3) * (W / h + 0.264)) / ((epsilon_eff - 0.258) * (W / h + 0.8));

% Step 5: Calculate the actual length L
L = L_eff - 2 * delta_L;

% Step 6: Calculate the position for 50 Ohm impedance
x = (L / pi) * acos(sqrt(Z_0 / Z_edge));

% Step 7: Calculate the width of the stripline
nepa_0 = 120*pi;
W_strip = (nepa_0*h)/(Z_0*sqrt(epsilon_r));

% Display the results
fprintf('Patch width (W): %.2f mm\n', W * 1e3);
fprintf('Effective dielectric constant (epsilon_eff): %.2f\n', epsilon_eff);
fprintf('Patch length (L): %.2f mm\n', L * 1e3);
fprintf('Position for 50 Ohm impedance (x): %.2f mm\n', x * 1e3);
fprintf('Width of the stripline: %.2f mm\n', W_strip * 1e3);

% Microstrip width calculation for 50 Ohms - iterative method
W_0 = 1e-3; % Initial guess for W_0 (in meters)
tolerance = 1e-6; % Tolerance for the solution
Z_0_target = 50; % Target impedance

for iteration = 1:1000
    Z_0_calc = (60 / sqrt(epsilon_eff)) * log((8 * h / W_0) + (W_0 / (4 * h)));
    if abs(Z_0_calc - Z_0_target) < tolerance
        break;
    end
    W_0 = W_0 - 1e-5 * (Z_0_calc - Z_0_target); % Adjust W_0 based on the error
end

fprintf('Microstrip width for 50 Ohms (W_0): %.2f mm\n', W_0 * 1e3);