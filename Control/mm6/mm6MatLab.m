plotoptions = bodeoptions;
s=tf('s');
open=(20/((s+10)*(s+2)))*exp(-5*s);
sys1 = open/(1+open);%initial bode plot of the system
%bode(sys1)
%xlim([0.01,1])
open2=open*0.564;
sys2=open2/(1+open2);
bode(sys1,sys2)
legend('sys1','sys2');
xlim([0.01,1])
%This shit no work