% Given system parameters
K = 1;  % Assuming K = 1, modify accordingly if you have another value
time_delay = 0.3;  % Time delay in seconds

% Transfer function without time delay
num = K;
den = [1 1];  % Transfer function for (s+1)
G = tf(num, den);

% First-order Pade approximation for the time delay
[n_delay_1st, d_delay_1st] = pade(time_delay, 1);  % First-order approximation

% Second-order Pade approximation for the time delay
[n_delay_2nd, d_delay_2nd] = pade(time_delay, 2);  % Second-order approximation

% Time delay transfer function for first-order Pade
time_delay_tf_1st = tf(n_delay_1st, d_delay_1st);

% Time delay transfer function for second-order Pade
time_delay_tf_2nd = tf(n_delay_2nd, d_delay_2nd);

% Combined system transfer function with first-order Pade approximation
G_pade_1st = G * time_delay_tf_1st;

% Combined system transfer function with second-order Pade approximation
G_pade_2nd = G * time_delay_tf_2nd;

% Display the transfer functions
disp('Transfer function with First-Order Pade approximation:');
G_pade_1st

disp('Transfer function with Second-Order Pade approximation:');
G_pade_2nd

% Plot root locus for first-order approximation
figure;
rlocus(G_pade_1st);
title('Root Locus of the System with First-Order Pade Approximation');

% Plot root locus for second-order approximation
figure;
rlocus(G_pade_2nd);
title('Root Locus of the System with Second-Order Pade Approximation');
