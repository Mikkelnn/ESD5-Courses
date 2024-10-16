% Define parameters
k = 100;   % spring constant (N/m)
c = 10;    % damping coefficient (Ns/m)
m1 = 1;    % mass 1 (kg)
m2 = 1;  % mass 2 (kg)

% State-space matrices
A = [0  0  1  0;
     0  0  0  1;
    -k/m1  k/m1  -c/m1  0;
     k/m2 -k/m2   0  -c/m2];
 
B = [0;
     0;
     c/m1;
     c/m2];

C = eye(4);   % Output all states (identity matrix)
D = zeros(4,1);

% Create state-space system
sys = ss(A, B, C, D);

% Time vector for simulation
t = 0:0.01:10;

% Control input (force or velocity v applied)
v = ones(size(t));  % For example, step input

% Initial conditions for state variables [x1, x2, v1, v2]
x0 = [0; 0; 0; 0];

% Simulate system response
[y, t, x] = lsim(sys, v, t, x0);

% Plot the results
figure;
subplot(4,1,1);
plot(t, x(:,1)); 
ylabel('x1 (Position of m1)');
title('System Response');

subplot(4,1,2);
plot(t, x(:,2)); 
ylabel('x2 (Position of m2)');

subplot(4,1,3);
plot(t, x(:,3)); 
ylabel('v1 (Velocity of m1)');

subplot(4,1,4);
plot(t, x(:,4)); 
ylabel('v2 (Velocity of m2)');
xlabel('Time (seconds)');
