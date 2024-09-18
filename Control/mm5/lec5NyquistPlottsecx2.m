% MATLAB script to display progressive Nyquist plots of the submarine system
% Starting from the integrators and adding controller and feedbacks step-by-step

% Clear workspace, close figures
clear;
clc;
close all;

% Parameters
K = 1;  % Gain K
a = 1;  % Feedback gain a
b = 1;  % Feedback gain b
epsilon = 1e-3; % Small value to ensure more realistic plots

% Step 1: Submarine dynamics only (3 integrators, no feedback or controller)
numerator_submarine = 1;
denominator_submarine = [1 0 0 0]; % Submarine dynamics: 1/s^3

sys_submarine = tf(numerator_submarine, denominator_submarine);

% Plot Nyquist plot for submarine only
figure;
nyquist(sys_submarine);
grid on;
title('Nyquist Plot of Submarine Dynamics (3 Integrators)');
pause(2); % Pause to observe the plot

% Step 2: Add controller (K)
numerator_controller = K;
denominator_controller = [1 0 0 epsilon]; % Adding small epsilon for damping
sys_controller = tf(numerator_controller, denominator_controller);

% Plot Nyquist plot for submarine + controller
figure;
nyquist(sys_controller);
grid on;
title('Nyquist Plot of Submarine Dynamics with Controller (K = 1)');
pause(2); % Pause to observe the plot

% Step 3: Add feedback loop a (first dotted feedback loop)
numerator_feedback_a = a;
denominator_feedback_a = [1 0]; % 1/s term from feedback loop a
sys_feedback_a = tf(numerator_feedback_a, denominator_feedback_a);

% Combine submarine, controller, and feedback a
sys_with_feedback_a = series(sys_controller, sys_feedback_a);

% Plot Nyquist plot for submarine + controller + feedback a
figure;
nyquist(sys_with_feedback_a);
grid on;
title('Nyquist Plot of Submarine + Controller + Feedback a');
pause(2); % Pause to observe the plot

% Step 4: Add feedback loop b (second dotted feedback loop)
numerator_feedback_b = b;
denominator_feedback_b = [1 0]; % 1/s term from feedback loop b
sys_feedback_b = tf(numerator_feedback_b, denominator_feedback_b);

% Combine everything: submarine + controller + feedback a + feedback b
sys_with_feedback_b = series(sys_with_feedback_a, sys_feedback_b);

% Plot Nyquist plot for full system with both feedback loops
figure;
nyquist(sys_with_feedback_b);
grid on;
title('Nyquist Plot of Full System (Submarine + Controller + Feedback a + Feedback b)');
