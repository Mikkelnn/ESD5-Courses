% Definer Laplace-variablen 's' til brug i overføringsfunktioner
s = tf('s');

% Definer systemmatricer
A = [7 -9;    % Systemets dynamik
     6 -8];
B = [4;       % Input-matrix
     3];
C = [1 1];    % Output-matrix

% Beregn styrbarhedsmatricen [B, AB]
Cc = [B, A*B];

rho_values = [0.1, 0.5, 1, 10, 100, 1000];
Fopts = cell(1, length(rho_values));
eig_results = zeros(2, length(rho_values)); % Preallocate for eigenvalues
zero()

for i = 1:length(rho_values)
    rho = rho_values(i);
    Fopts{i} = -lqr(A, B, rho * C' * C, 1);
    eig_results(:, i) = eig(A + B * Fopts{i});
end

% Display Fopts and eig_results
disp('Fopts:');
disp(Fopts);

disp('Eigenvalues:');
disp(eig_results);



