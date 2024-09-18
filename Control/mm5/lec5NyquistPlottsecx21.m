% MATLAB script to display Nyquist plot of the submarine system
% with K = 1, a = 1, b = 1 and a small damping term

% Clear workspace, close figures
clear;
clc;
close all;

% Parameters
K = 1;  % Gain K
a = 1;  % Feedback gain a
b = 1;  % Feedback gain b

% Define the open-loop transfer function G(s) = K / (s^3 + epsilon)
% Adding a small epsilon to avoid purely integrative dynamics
epsilon = 1e-3; % Small value to ensure a more realistic Nyquist plot
numerator = K;
denominator = [1 0 0 epsilon]; % Slightly modify denominator (s^3 + epsilon)

% Create the transfer function for G(s) = K / (s^3 + epsilon)
sys = tf(numerator, denominator);

% Display the transfer function
disp('Open-loop Transfer Function (without dotted feedback):');
sys

% Plot Nyquist plot
figure;
nyquist(sys);
grid on;
title('Nyquist Plot of Open-loop System (K = 1, a = 1, b = 1)');
