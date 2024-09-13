s=tf('s');
sys1 = 10/(s*(s+1)*(s+2));
%bode(sys1)
lead = (8/0.3)*((s/0.3+1)/(s/8+1));
sys2 = sys1*lead;
%bode(sys2,sys1)
%legend('sys2', 'sys1');
sys3 = sys2*0.007;
%bode(sys1,sys2,sys3)
%legend('sys1','sys2', 'sys3');
lag = (1+300000*s)/(1+1500*s);
sys4 = sys2*lag;
%bode(sys1,sys2,sys4)
%legend('sys1','sys2','sys4');
sys5 = (1/27000)*sys4;
bode(sys1,sys2,sys3,sys4,sys5)
legend('sys1','sys2','sys3','sys4','sys5');