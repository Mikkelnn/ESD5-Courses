% Direct Form I implementation (Filter Coefficients)
b = 0.0317 * [1 3 3 1];   % Numerator coefficients
a = [1 -1.4590 0.9104 -0.1978];  % Denominator coefficients

% Plot Direct Form I filter structure
figure;
subplot(2,1,1);
title('Direct Form I Filter Structure');
xlim([0 7]);
ylim([-2 2]);

% Input x[n]
text(0, 1.2, 'x[n]', 'FontSize', 12);
line([1 2], [1 1], 'Color', 'black');

% Numerator section (FIR)
text(2.5, 1.2, sprintf('b_0 = %.4f', b(1)), 'FontSize', 12);
line([3 4], [1 1], 'Color', 'black');
text(2.5, 0.7, sprintf('b_1 = %.4f', b(2)), 'FontSize', 12);
text(2.5, 0.2, sprintf('b_2 = %.4f', b(3)), 'FontSize', 12);
text(2.5, -0.3, sprintf('b_3 = %.4f', b(4)), 'FontSize', 12);

% Denominator section (IIR)
text(4.5, 1.2, sprintf('a_1 = %.4f', a(2)), 'FontSize', 12);
text(4.5, 0.7, sprintf('a_2 = %.4f', a(3)), 'FontSize', 12);
text(4.5, 0.2, sprintf('a_3 = %.4f', a(4)), 'FontSize', 12);

% Output y[n]
text(6, 1.2, 'y[n]', 'FontSize', 12);
line([5 6], [1 1], 'Color', 'black');


% Direct Form II implementation (Filter Coefficients)
b = 0.0317 * [1 3 3 1];   % Numerator coefficients
a = [1 -1.4590 0.9104 -0.1978];  % Denominator coefficients

% Plot Direct Form II filter structure
figure;
subplot(2,1,1);
title('Direct Form II Filter Structure');
xlim([0 7]);
ylim([-2 2]);

% Input x[n]
text(0, 1.2, 'x[n]', 'FontSize', 12);
line([1 2], [1 1], 'Color', 'black');

% Shared delay line (for both numerator and denominator)
text(2.5, 1.2, 'Delay Elements', 'FontSize', 12);

% Coefficients for Direct Form II
text(4.5, 1.2, sprintf('b_0 = %.4f', b(1)), 'FontSize', 12);
text(4.5, 0.7, sprintf('a_1 = %.4f', a(2)), 'FontSize', 12);
text(4.5, 0.2, sprintf('b_1 = %.4f', b(2)), 'FontSize', 12);
text(4.5, -0.3, sprintf('a_2 = %.4f', a(3)), 'FontSize', 12);
text(4.5, -0.8, sprintf('b_2 = %.4f', b(3)), 'FontSize', 12);
text(4.5, -1.3, sprintf('a_3 = %.4f', a(4)), 'FontSize', 12);

% Output y[n]
text(6, 1.2, 'y[n]', 'FontSize', 12);
line([5 6], [1 1], 'Color', 'black');
