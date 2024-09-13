s=tf('s');
sys1 = 10/(s*(s+1)*(s+2));%initial bode plot of the system
%bode(sys1)
lead = (8/0.3)*((s/0.3+1)/(s/8+1));%The calculated lead response that needs to be added
sys2 = sys1*lead;%The response of the system with the lead response added
%bode(sys2,sys1)%Plot comparing system 1 and 2
%legend('sys2', 'sys1');
sys3 = sys2*0.007;%Added a constant k that hopefully makes the system meet every criteria
%bode(sys1,sys2,sys3)%plot compairing the 3 systems found so far
%legend('sys1','sys2', 'sys3');
lag = (1+300000*s)/(1+1500*s);%As adding only lead does not meet every criteria, lag needs to be added
sys4 = sys2*lag;
%bode(sys1,sys2,sys4)%plot comparing the start system with the lag system
%and lag/lead system without constants
%legend('sys1','sys2','sys4');
sys5 = (1/27000)*sys4;%Calculated constant to match the Kv criteria
bode(sys1,sys2,sys3,sys4,sys5);%Final plot comparing the systems and checking if 
%the lead/lag system meets the criteria
legend('sys1','sys2','sys3','sys4','sys5');
ClosedLoop = sys5/(1+sys5);%Closed loop transfer function with perfect sensor
step(ClosedLoop);%step response
step(ClosedLoop/s,14)  %ramp response