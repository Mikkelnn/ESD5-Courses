% MATLAB script to display Nyquist plot of the transfer function:
% G(s) = K / (s + (tau*s + 1))

% Clear workspace, close figures
clear;
clc;
close all;

% Parameters
K = 1;     % Gain
tau = 1;   % Time constant

% Define the transfer function G(s) = K / (s + (tau*s + 1))
numerator = K;
denominator = [tau 1 1]; % Coefficients of (tau*s + 1) in the denominator

sys = tf(numerator, denominator);

% Display the transfer function
disp('Transfer Function:');
sys

% Plot Nyquist plot
figure;
nyquist(sys);
grid on;
title('Nyquist Plot of G(s) = K / (s + (tau*s + 1))');
