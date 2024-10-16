%For styrbar form mm12
%Find chanonical controlable form
A = [7 -9;
     6 -8];
B = [4;
     3];
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
C = [1 1];
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
     -L*C A+L*C+B*F])