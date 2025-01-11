% Define system matrices
A = [7 -9; 6 -8];
B = [4; 3];
C = [1 1];
F = [-2 2]; % State feedback gain
L = [-5; -3]; % Observer gain

% Augmented system matrices for the observer-based controller
A_aug = [A, B * F; -L * C, A + B * F + L * C];
B_aug = [B; B];
C_aug = [C, zeros(size(C))];
D_aug = 0; % No direct feedthrough term

% Create the state-space system
sys_aug = ss(A_aug, B_aug, C_aug, D_aug);

% Generate the Bode plot
figure;
bode(sys_aug);
grid on;
title('Bode Plot of the Observer-Based Controller System');
pole1 = -1.4;
pole2 = -4;
place( (A* B * F) + (L * F)' , F', [pole1, pole2])'
