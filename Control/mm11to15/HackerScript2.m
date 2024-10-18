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
eig(Ao+Lo*Co);
eig(A+L*C);
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
zpk(sysCL)