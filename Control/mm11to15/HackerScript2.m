s = tf('s');

%For styrbar form mm12
%Find chanonical controlable form
A = [7 -9;
     6 -8];
B = [4;
     3];
C = [1 1];
Cc = [B, A*B];
s2 = [0 1]*inv(Cc);
s1 = s2*A;
Tinv = [s1;
        s2];
Ac = Tinv*A*inv(Tinv);
%Make it to our wanted poles
Fx = [-2 -4];
F = Fx*Tinv;
A+B*F;
Ac+[1;0]*Fx;


%For obsaverbar form mm13
%initialisering
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
L
eig(Ao+Lo*Co);
eig(A+L*C);
eig(A+B*F);
eig([A B*F; ...
     -L*C A+L*C+B*F]);

%mm14 her
Te = [1 -1;
     0 1];
Ae = inv(Te)*A*Te;
Be = inv(Te)*B;
Ce = C*Te;
Le = -1/3;
Fe = F*Te;
Ar = Ae(2,2) + Le*Ae(1,2) + (Be(2)+Le*Be(1))*Fe(2);
Br = Ae(2,1) + Le*Ae(1,1) + (Be(2)+Le*Be(1))*Fe(1) - Ar*Le;
Cr = Fe(2);
Dr = Fe(1) - Fe(2)*Le;
K = Cr*inv((s*eye(1) - Ar))*Br + Dr;
H = ss(A,B,C,zeros(1,1));
sysCL = feedback(K,H,1);
zpk(sysCL);


%mm15
Acl = [A B*F; ...
       -L*C A+L*C+B*F];
Bstor = [B
         B];
Cstor = [C 0 0];
H1 = 0.25*ss (Acl,Bstor,Cstor,zeros(1,1));
figure;
hold on;
bode(H1);
Mt1 = place((A+B*F+L*C).',F.',[-1,-2]).';
Bcl1 = [B
       Mt1];
N1 = -inv(Cstor*inv(Acl)*Bcl1);
M1 = Mt1*N1;
Bny1 = [B*N1
       M1];
H2 = ss(Acl,Bny1,Cstor,zeros(1,1));
bode(H2);
Mt2 = place((A+B*F+L*C).',F.',[-1.4,-4]).';
Bcl2 = [B
       Mt2];
N2 = -inv(Cstor*inv(Acl)*Bcl2);
M2 = Mt2*N2;
Bny2 = [B*N2
       M2];
H3 = ss(Acl,Bny2,Cstor,zeros(1,1));
bode(H3);
legend('No zeros', 'With zeros in -1 and -2', 'With zeros in -1.4 and -4');
hold off