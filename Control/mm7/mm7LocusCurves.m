s=tf('s');
SysA = (s+4)/(s*(s+2));
figure;
rlocus(SysA)
SysB = (s+4)/((s+2+i*1)*(s+2-i*1));
figure;
rlocus(SysB)
SysC = (s+4)/s^2;
figure;
rlocus(SysC)
SysD = ((s+6)*(s+4))/(s*(s+2));
figure;
rlocus(SysD)
SysE = 1/((s+2+i*1)*(s+2-i*1)*(s-2));
figure;
rlocus(SysE)
SysF = (s+2)/((s+4+i*2)*(s+4-i*2)*(s-2)*(s+i*1)*(s-i*1));
figure;
rlocus(SysF)