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

% Generér Bode-plot for systemet uden nulpunkter
figure(1);
hold on;
bode(H1);

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

% Beregn den nye input-matrix
M1 = Mt1 * N1;
Bny1 = [B * N1;
        M1];

% Definer systemet med nulpunkter i -1 og -2
H2 = ss(Acl, Bny1, Cstor, zeros(1,1)); % Tilstandsrum-model
bode(H2);                             % Tilføj Bode-plot

% -------------------------
% Tilføj nulpunkter (-1.4, -4) (de bedste)
% -------------------------
% Placér nulpunkter i -1.4 og -4
Mt2 = place((A + B*F + L*C).', F.', [-1.4, -4]).'; % Observer gain for nye nulpunkter

% Kombinér med input-matrix
Bcl2 = [B;
        Mt2];              % Kombiner systemets input med observer gain

% Beregn skaleringsfaktor for at justere det samlede input
N2 = -inv(Cstor * inv(Acl) * Bcl2);

% Beregn den nye input-matrix
M2 = Mt2 * N2;
Bny2 = [B * N2;
        M2];

% Definer systemet med nulpunkter i -1.4 og -4
H3 = ss(Acl, Bny2, Cstor, zeros(1,1)); % Tilstandsrum-model
bode(H3);                             % Tilføj Bode-plot
% -------------------------
% Tilføj nulpunkter (-1.4, -4) (de værste)
% -------------------------
% Placér nulpunkter i -1.4 og -4
Mt2 = place((A + B*F + L*C).', F.', [-1.4, -4]).'; % Observer gain for nye nulpunkter

% Kombinér med input-matrix
Bcl2 = [B;
        Mt2];              % Kombiner systemets input med observer gain

% Beregn skaleringsfaktor for at justere det samlede input
N2 = -inv(Cstor * inv(Acl) * Bcl2);

% Beregn den nye input-matrix
M2 = Mt2 * N2;
Bny2 = [B * N2;
        M2];

% Definer systemet med nulpunkter i -1.4 og -4
H4 = ss(Acl, Bny2, Cstor, zeros(1,1)); % Tilstandsrum-model
bode(H4);                             % Tilføj Bode-plot


% -------------------------
% Visualisering
% -------------------------
% Tilføj forklaring til Bode-plottet
legend('No zeros', 'With zeros in -1 and -2', 'With zeros in -1.4 and -4', 'With zeros in the worst');
hold off;

rho=0.1;
Fopt01=-lqr(A,B,rho*C'*C,1);
rho=0.5;
Fopt05=-lqr(A,B,rho*C'*C,1);
rho=1;
Fopt1=-lqr(A,B,rho*C'*C,1);
rho=10;
Fopt10=-lqr(A,B,rho*C'*C,1);
rho=100;
Fopt100=-lqr(A,B,rho*C'*C,1);
rho=1000;
Fopt1000=-lqr(A,B,rho*C'*C,1);
rho=10000;
Fopt10000=-lqr(A,B,rho*C'*C,1);

eig01=eig(A+B*Fopt01);
eig05=eig(A+B*Fopt05)
eig1=eig(A+B*Fopt1);
eig10=eig(A+B*Fopt10);
eig100=eig(A+B*Fopt100);
eig1000=eig(A+B*Fopt1000);
eig10000=eig(A+B*Fopt10000);
