% MATLAB script to design a lead compensator using root locus

% Given transfer function G(s) = 10 / (s(s+1))
num = 10;
den = [1 1 0]; % s(s+1) -> s^2 + s

G = tf(num, den);

% Desired damping ratio and natural frequency
zeta = 0.5;  % Damping ratio
omega_n = 3; % Natural frequency

% Desired closed-loop characteristic equation: s^2 + 3s + 9
desired_poles = roots([1 3 9]);

% Display the root locus of the open-loop transfer function
figure;
rlocus(G);
title('Root Locus of the Open-Loop System');
grid on;

% Check step response of the closed-loop system
figure;
step(feedback(G, 1));
title('Step Response of the System');


% Add lead compensator design using rlocus:
% Select gain (K) that places the poles at the desired locations
K = 0.07;  % Adjust this gain value based on root locus plot

% Closed-loop system with compensator
Gc = K * G;

% Check step response of the closed-loop system
figure;
step(feedback(Gc, 1));
title('Step Response of the Compensated Closed-Loop System');

% Display closed-loop poles
cl_poles = pole(feedback(Gc, 1));
disp('Closed-Loop Poles:');
disp(cl_poles);
