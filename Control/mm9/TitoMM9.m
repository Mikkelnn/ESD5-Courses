H0 = [-10 3
      -11 10];
RGA = H0.*inv(H0.')
lambda = RGA(1,1) % as lambda is over 1 closed loop gain>open loop gain
%Also as lambda>0.5 the loops should NOT be interchanged, which means U1
%should be paired with Y1
%F11 = 1
%F22 = 1
%F12 = -H12(s)/H22(s)
%F21 = -H21(s)/H11(s)
%Så har du decouplet