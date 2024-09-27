s = tf('s');
Sys1 = 1/(s+1);
figure(1);
rlocus(Sys1);
title('Root Locus of system without time delay');

Td = 0.3;
Pade = (1-(Td/2)*s)/(1+(Td/2)*s);
Sys2 = Pade/(s+1);
figure(2);
rlocus(Sys2);
title('Root Locus of system with time delay');

Sys3 = (s^2+2*s+4)/(s*(s+4)*(s+6)*(s^2+1.4*s+1));
figure(3);
rlocus(Sys3);
title('Excercise 2 root locus plot');

%Chat kode
% Plot the root locus
figure(4);
rlocus(Sys3); 
hold on;

% Plot the vertical line at x = 0 (the imaginary axis)
xline(0, 'r--', 'LineWidth', 2);  % red dashed line at x=0

% Find poles for a range of gains using the root locus
[K, poles] = rlocus(Sys3);

% Now find the poles where the real part is approximately zero (i.e., crossing the imaginary axis)
tolerance = 1e-6;  % Tolerance for considering real part as zero
imaginary_axis_poles = poles(abs(real(poles)) < tolerance);

% Highlight the poles that are on the imaginary axis
plot(real(imaginary_axis_poles), imag(imaginary_axis_poles), 'bo', 'MarkerSize', 10);

% Display the gains corresponding to the crossing points
for i = 1:length(imaginary_axis_poles)
    fprintf('Root locus crosses imaginary axis at s = %.4f j, for K = %.4f\n', ...
        imag(imaginary_axis_poles(i)), K(i));
end

hold off;