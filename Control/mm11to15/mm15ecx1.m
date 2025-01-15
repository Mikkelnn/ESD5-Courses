% Definer Laplace-variablen 's' til brug i overføringsfunktioner
s = tf('s');

% -------------------------
% Styrbar form (mm12)
% -------------------------
% Definer systemmatricer
A = [7 -9;    % Systemets dynamik
     6 -8];
B = [4;       % Input-matrix
     3];
C = [1 1];    % Output-matrix

Lo =[-8;
     -22];
O = [C;
     C*A];
%step 1
t2 = inv(O)*[0;1];
%Step 2
t1 = A*t2;
%Step 3
To = [t1 t2];
%Step 4
Ao = inv(To)*A*To;
Co = C*To;
%Tjek om svaret er rigtigt
L = To*Lo;


% Beregn styrbarhedsmatricen [B, AB]
Cc = [B, A*B];

% Find koefficienterne til den kanoniske styrbare form
s2 = [0 1] * inv(Cc); % Udtræk den anden række af transformationsmatricen
s1 = s2 * A;          % Udtræk den første række ved at gange med A

% Saml transformationsmatricen
Tinv = [s1;            % Første række
        s2];           % Anden række

% Transformér A til kanonisk styrbar form
Ac = Tinv * A * inv(Tinv);

% Definer feedback-gain, der placerer polerne
Fx = [-2 -4];            % Ønskede polplaceringer i det lukkede system
F = Fx * Tinv;           % Transformér feedback-gain tilbage til original basis

% Beregn det lukkede system i den oprindelige basis
A + B * F;               % Lukket system i original basis
Ac + [1; 0] * Fx;        % Lukket system i styrbar basis

% -------------------------
% Observer-baseret controller (mm15)
% -------------------------

% Definer det observer-baserede lukkede loop-system
Acl = [A B*F;            % Øverste blok: A + BF
       -L*C A + L*C + B*F]; % Nederste blok: Observer dynamik

% Kombinér input-matricer for det samlede system
Bstor = [B;
         B];

% Kombinér output-matricer for det samlede system
Cstor = [C 0 0];         % Tilføj nuller til output-matrix

% Definer systemet uden nulpunkter
H1 = 0.25 * ss(Acl, Bstor, Cstor, zeros(1,1)); % Opret tilstandsrum-model

% -------------------------
% Tilføj nulpunkter (-1, -2)
% -------------------------
% Placér nulpunkter i -1 og -2
Mt1 = place((A + B*F + L*C).', F.', [-1, -2]).'; % Observer gain for nulpunkter

% Kombinér med input-matrix
Bcl1 = [B; 
        Mt1];              % Kombiner systemets input med observer gain

% Beregn skaleringsfaktor for at justere det samlede input
N1 = -inv(Cstor * inv(Acl) * Bcl1);
N1
% Beregn den nye input-matrix
M1 = Mt1 * N1;
Bny1 = [B * N1;
        M1];
M1
Bny1

% Definer systemet med nulpunkter i -1 og -2
H2 = ss(Acl, Bny1, Cstor, zeros(1,1)); % Tilstandsrum-model

% -------------------------
% Tilføj nulpunkter (-1.4, -4) (de bedste)
% -------------------------
% Placér nulpunkter i -1.4 og -4
Mt2 = place((A + B*F + L*C).', F.', [-1.4, -4]).'; % Observer gain for nye nulpunkter
Mt2

% Kombinér med input-matrix
Bcl2 = [B;
        Mt2];              % Kombiner systemets input med observer gain
Bcl2
% Beregn skaleringsfaktor for at justere det samlede input
N2 = -inv(Cstor * inv(Acl) * Bcl2);
N2
% Beregn den nye input-matrix
M2 = Mt2 * N2;
Bny2 = [B * N2;
        M2];
Bny2
% Definer systemet med nulpunkter i -1.4 og -4
H3 = ss(Acl, Bny2, Cstor, zeros(1,1)); % Tilstandsrum-model

% -------------------------
% Visualisering
% -------------------------

% Generér Bode-plot
figure(1);
hold on;
bode(H1);
bode(H2);
bode(H3);
legend('No zeros', 'With zeros in -1 and -2', 'With zeros in -1.4 and -4');
hold off;

% Generér step responses
figure(2);
hold on;
step(H1);
step(H2);
step(H3);
legend('No zeros', 'With zeros in -1 and -2', 'With zeros in -1.4 and -4');
title('Step Responses');
hold off;
